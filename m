Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E816B5F86
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCKSGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjCKSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:06:36 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C450996
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:06:35 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bi9so10739350lfb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678557993;
        h=subject:cc:to:from:user-agent:mime-version:date:in-reply-to
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0M0jtqvAdY5YLi17aN4+4DCugAJ4kvRlpg9cOQFT1qw=;
        b=Hd0yYlc/zLCCUp99NDFRaRlWlBMf1m/+vLzypRAErw4qqaOGYGsWuRkPXd0zo9toOq
         k4Pz+T26WakI3HCzW8vVeLq27mDAkR8XKstBfLKqHmZ6vG8FMutR6oBsJcZOjUnlgwx3
         23MJP0o6xZwYSdzV4FztWwKM0uvUGgmeJ/264Ake1wDV8IeDGWOSEBBAluiSq1yn6DWm
         PonVr7vqDYe44hhW/88ShA93+mgyApk2Lh13pL6QlsMhE67aThTDBlkcV67FYSDAXNOM
         9WyBk4jLB+ad2cZn4v8K20EwIvlgwAk3QgEIYdipEgBckz1Ef6DeOuWA+ILnhXXTaZMQ
         TorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678557993;
        h=subject:cc:to:from:user-agent:mime-version:date:in-reply-to
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0M0jtqvAdY5YLi17aN4+4DCugAJ4kvRlpg9cOQFT1qw=;
        b=ta+X/sCCUR6jiEKaHAJw+iRtrHK8fqcuK6F677wgHOBLdbhxX/fTnBVreTRnuGuzjA
         cvP2isqUvXSWgmvPlNeC4cCXl9y07yR1ITlU3Lb06E9M2bJvHxUqP6WvbzjuVxxVtmJb
         K3fOXPv/jRfNNxX0e1G3MhapeReYuZGPjDH7LXDQ2uoCnmvVTQCnw33roMxweZ+lPcQL
         EDAwQ6idgtUjdRdl7uwvM/iNu2mZbPkGtyNFS4sjxTJbXfcOq6frK4oDDa912rNJj3g5
         yghpZEZzpav4azTLlf4D1uxMOu51Rf3uaUfLYxNowPJR3cxs/bduxKynA2UWBD8VcHPH
         Kx+g==
X-Gm-Message-State: AO0yUKWdqMWeTcgelm9Rw8ecC8JFqJpG3m8Hs6ulgJ+Q2LeD8gqpj1/i
        gP0eyY1ojd3QAgXwCXd7h8XFD+zpDKqmrpjyQsM=
X-Google-Smtp-Source: AK7set+/vVXIWCNzzFJfmUxd01+2RADRFbQ90zNQQFoIwZkQAN6sEyuXyxmjITivCmnx5DIAfEKVgg==
X-Received: by 2002:ac2:4421:0:b0:4e0:ff8e:bbfe with SMTP id w1-20020ac24421000000b004e0ff8ebbfemr7716401lfl.12.1678557993512;
        Sat, 11 Mar 2023 10:06:33 -0800 (PST)
Received: from letter2.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id a20-20020ac25214000000b004d988f59633sm382316lfl.161.2023.03.11.10.06.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 10:06:33 -0800 (PST)
Message-ID: <640cc329.c20a0220.63661.0de9@mx.google.com>
In-Reply-To: <4de11c0b-8e09-c3ef-4180-585662386859@linaro.org>
Date:   Sat, 11 Mar 2023 18:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Sergey Lisov <sleirsgoevy@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] devicetree: synopsys-dw-mshc-common: add "fifo-access-32bit" property
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why did you remove the subject? Please keep the mailing process matching
> mailing lists. It messes with mailboxes, filters and reading process.

Sorry about this, I just wanted to get rid of those X-Something headers and
accidentially deleted this one.

> Yeah, Rob acked it so I will let him to judge this. To me it looks like
> unnecessary fragmentation - this looks like compatible specific, not
> board. Anyway you need to resend to fix all the mailing mess.
> 
> Best regards,
> Krzysztof

Should I resend the whole patchset from scratch, as if nothing happened?
