Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D556414FA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 09:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLCIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 03:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLCIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 03:37:20 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5792183E
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:37:19 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m19so5142024wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Dec 2022 00:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YQS61NX1Em5a//DyKuM2uuh+62pP/e6si2f0EakzPms=;
        b=Yv/Sj45myY9Eit4EqdZPMgKDWHOuN0KlxU948jv96xEj9zWcgJeYTHwSdELzVIiYJ4
         sThn21T727f7KcV6LBlVOYDaakFD/CCqNIxPnkWMLd7ph63rkkoH1SDm5trhTPoSZjpo
         zclEvVban/0BEU3LcqOUlITBwJ1j/Z0OhVbRfXlZGQyQqhMSO6XWoK6Pm5vl323A9S65
         fXmXZSPjThLu1Gu7v2P+rPyW00mb2jwkmWSRg41mRRw5kBp45XErVzOMfiE3JHS07dUx
         /kXcvqpVej2TrPqNcsHh2xoqWy6dHqLfJCsFOmlp2pkvO0P8zxiZ63MM7A16zIPn5p3T
         ZNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQS61NX1Em5a//DyKuM2uuh+62pP/e6si2f0EakzPms=;
        b=yq1iLYZRY0C/Cay6kED6YV/Yip2XkehjygMIoOm6ki3ulxU1777RClRDrxPJq5iyJ0
         Ezw+kruU94vtQ9JDyHY9pvZHr3/NCYzLZitrhXfcJ9b3RG6ysSWk9JOgvE31A5bBiqKL
         knDeA1hF48ycUjVeDwVb3zk0Z0slmUp0RrEHetYqS3oBAJrY+TADq19KfMSGmQJrA5jm
         35s2ux4AdelYSfxxlss7i50cy29MwRgKHeSRkFBLOv9OXlCdhB1n6iELPeoaEEfjxMd2
         gErdRKbXm6u+1gwOu/G51hCA1ldlG+TgcOUuzYc+hDvrepgTRKpyq0Z7lbcfv62giR0e
         9s8g==
X-Gm-Message-State: ANoB5plyMJXV8SqxO95lwWR+Z7UT2PF0Hl+rEQLn+H1Ejxn0b7K/GPb3
        9/cU+7Q8HFILVJRgp3c8my1sdMZtJIJzGw==
X-Google-Smtp-Source: AA0mqf6Y6TXvMtIrlRMjQMb5ja6ZOaIAq0Y8Q1pUS5ChZzfJvtfPL4kPWzRUeoHPLRP8hm28zT4zfQ==
X-Received: by 2002:a05:600c:538d:b0:3d0:47c:b2ac with SMTP id hg13-20020a05600c538d00b003d0047cb2acmr41051027wmb.52.1670056637511;
        Sat, 03 Dec 2022 00:37:17 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bs4-20020a056000070400b0023677081f3asm9022986wrb.42.2022.12.03.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 00:37:17 -0800 (PST)
Date:   Sat, 3 Dec 2022 11:37:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Joe Peterson <jwp.linux@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: board: Remove control flow from macro
Message-ID: <Y4sKulRutmI+ESrB@kadam>
References: <20221203030544.11543-1-jwp.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203030544.11543-1-jwp.linux@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 09:05:44PM -0600, Joe Peterson wrote:
> Adhere to Linux coding style
> 
> Reported by checkpatch:
> 
> WARNING: Macros with flow control statements should be avoided
> 
> There is only one return value possible. Remove the checkpatch warning
> without effecting functionality.
> 
> Signed-off-by: Joe Peterson <jwp.linux@gmail.com>
> ---

Does this break the build?

Anyway, checkpatch is wrong here.  Just ignore checkpatch if it says
silly stuff.

regards,
dan carpenter

