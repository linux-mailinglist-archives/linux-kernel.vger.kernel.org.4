Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D87736783
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjFTJSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjFTJSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:18:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A81987
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:17:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 38308e7fff4ca-2b47354c658so33822421fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687252675; x=1689844675;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpOpGI4zr8hV/jsPsRSuOxtwldQ8J6JsN4R/E9dIl5E=;
        b=ba4uJMiyDKBbMXcXSj4BY90Wo8g8yRy8gnSuZARTxt4Yy2qNs+qatg5ab5+5W/atit
         AoHpsqzeDX4rjqPPTsgYF0d4OFyEsLp9aI/y9p1e07BDko+WZ9x2NpqnY76xjQFXL5lN
         POyYmLJMnc9Xfrwbd3YXwE8tEZNhAXzm3socdAh38a2WvE5Jd9u0aIO7qLPClNOXqHh4
         TjJN3feriRur+GKXbj15KPBBICyXXBaZf6RqB+dIihdXXr5El+cjBXGuIQ/GJW3vyW5a
         847i5G/dV2mJqca/2NM4Q1AWXwOJd2u3ap0Td0VVMp0wwzbf4ExMlFPF/MWX1DAMrVZb
         2LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687252675; x=1689844675;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpOpGI4zr8hV/jsPsRSuOxtwldQ8J6JsN4R/E9dIl5E=;
        b=IVpVrkXwvb/MEeOMQNBOMQLM+w4ufWi55WoFq0ECsndpGYr0YmgqsVixqWSsc8ji7P
         m8kgYEPs3k08/8q37xbGhr4cnpxDXDEj1b0xXyw+sHhcfL4AsWI9WElvBt8fZreEggcH
         X/WNYyZlF7g21uSrq70dzJsxmm42kpSCRrRXRkNJxNcHVvpbqwznlK7OATJPn4WheRdj
         o72fETKng3uUVkC/krYm/oe0ZjHK8tO+ReMbGsd1tbzf4vlBIp+GgVKGTUyUr2SA0UcY
         q04NJhwtZ9Fg1QvuXiHuD8OacbQ5r1oG/gkc+4/W1WQr+QSMTbIqRm2vI+fw3pkMzPTC
         q3Vg==
X-Gm-Message-State: AC+VfDy4K1P4Dy0eM1tVOpW7cJgbf5D3wBi5kJFJDTvpmshamTX2BghQ
        bsHQXPl/QE9fuHSMd5Hf/jo=
X-Google-Smtp-Source: ACHHUZ49NLjhUl+SfP8hbSKn8m6MJJOJp2SS07VwErK13bmkobMNxQs4Nr3gDA5ez0v9uOTSETAN/w==
X-Received: by 2002:a2e:3606:0:b0:2b4:7c90:c7bb with SMTP id d6-20020a2e3606000000b002b47c90c7bbmr2965066lja.26.1687252674457;
        Tue, 20 Jun 2023 02:17:54 -0700 (PDT)
Received: from [10.0.52.202] ([80.247.38.157])
        by smtp.gmail.com with ESMTPSA id z14-20020a2e9b8e000000b002b3465d344esm321069lji.44.2023.06.20.02.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 02:17:54 -0700 (PDT)
Message-ID: <b0c62f6f-d6a6-92a1-496a-5084f9758f60@gmail.com>
Date:   Tue, 20 Jun 2023 12:17:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     yhao016@ucr.edu
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.or,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
Content-Language: ru
From:   admamiac <admamiac@gmail.com>
In-Reply-To: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Are kernels prior to version 6.2 affected by this issue?

