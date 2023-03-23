Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE926C6994
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjCWNeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCWNeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:34:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7018A9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:34:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so857292wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679578457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqF0ANcEeubBIPy3fcclIhfrDjvysj0GkmGUcwq4B7Q=;
        b=PQtIgwkOSXXI/LcqPzYcutQY0b0TLChaDvDfX3cvNmIBwod6mDaVMAyta1vGNqP53S
         H4FKPtQN9jLWxKa/BI0cKXK1q0/QirPNfEF9lnXcLlbzbC07YLLitg5YNby9DTmgKuHk
         5fa03hDP5Nj/KjzN8xlQd0wwm5lQ/GK7JHmBPduGA/qDOHtbQ/xYkRCVxmQUGT5AWoHG
         Jv2HjNwWDBsabjM023HuUhHx4kcJ2tluqQ5x2pjaAUjJRs0TTztwtbO7X+P37nU/MwR4
         O96Altx/eFeFZcNLZJ6pjjMFf81wekG/FkA+WeNsK7kyBOKVhyvgYbU+LOiWmHXmcyb9
         p2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679578457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqF0ANcEeubBIPy3fcclIhfrDjvysj0GkmGUcwq4B7Q=;
        b=XbkzlYGEqGXU3l/6YVcTVtMfv9G/D88GqekvrFq/G+h9oIaMcq+S2CDSn18aNor5ap
         ANYSH5VZfRba1n8CIfqCoZYWhdgkdVfsBijONdslURF7PaLB03NIheW8VV4sl7eApHKQ
         78MQLPUSIRmVg9WxyBNXUHExpTWtnNcw5Ghf5dcGyzkE7et3cGM5pdnpyWnsELIyjTyj
         2hxWtEAuXJ8i0X1ZtKK697CvczP3xtt8QAjGV0GMFg3Lag9wp4z3xBIh4d9rE38Y0e3d
         t/veHS9gYCV5i9rREv6rbY68ElP3vXB5jCWNZOQm7MSw1l/cIB65l8tDYUBT+wj5zD75
         mebA==
X-Gm-Message-State: AO0yUKUFH29nLNGYIBzFVRuJ2KNZYXPaXTWBzksoqjCNReDin/ecuF6B
        fWV2seH8nlP3wWt6wZicVkOZBSxLzHk=
X-Google-Smtp-Source: AK7set8tWZ+c9CDrcNYZ6FFbHJdBnTyggT1lvYMQcU2SQ4u1U2OEi7JTfgURGFmj8DYaP370Crz0zA==
X-Received: by 2002:a05:600c:285:b0:3ee:5a48:5b54 with SMTP id 5-20020a05600c028500b003ee5a485b54mr2326861wmk.16.1679578457139;
        Thu, 23 Mar 2023 06:34:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j36-20020a05600c1c2400b003ebf73acf9asm6571831wms.3.2023.03.23.06.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 06:34:16 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:34:06 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 RESEND] staging: vme_user: Replace "<<" with BIT macro
Message-ID: <9375f16c-5040-4355-8bd0-54c07763d6b3@kili.mountain>
References: <ZBxOdihP+mygNsuS@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxOdihP+mygNsuS@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 06:34:54PM +0530, Abhirup Deb wrote:
> Replace the "<<" operator with BIT macro, in accordance to the
> checkpatch.pl script and Linux kernel coding-style guidelines.
> 
> Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
> ---
> Changes in v2:
>     - Refactor the patch & Replace the erroneous BIT macro in --
>        "#define TSI148_PCFS_STAT_SELTIM        BIT(9)"
>       with --
>        "#define TSI148_PCFS_STAT_SELTIM        (3<<9)"
> 

Why did you resend this?

regards,
dan carpenter

