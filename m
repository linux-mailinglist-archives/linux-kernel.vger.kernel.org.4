Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40D6ADB37
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjCGJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjCGJ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:57:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB6A5DEF1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:57:31 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so49837670edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 01:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678183050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFfKfYm0N3LqI8J25elWBtfff5jc/IewGs/5ZXYbR2Y=;
        b=k/vFYgRI98XywIxfj6etk9eZK/GVCsBdkpfc2n830ZoUNYN70vLMXrdPpyp6Xixy2f
         PnXogX/1ic6pQAzaJziIPKpGGC1V0OavKzBzXhOnW1askbYrC2BZOHPGS7pR728a/5ME
         VTUZtASbT9xpvwVOMvHejY+iAaV0sT9NHAhpDDqLesymV4Bb8NpYexKvzKdEJGkGIF90
         2sdLCgKptczVcCk7Jy5vP0quDNXcmlJuNK7Xq2/VGH0ZYyHv/qbq5JM8uq5th831itak
         yhtmCHkqMuEe/elS4BnDDeO6TcBsPhdbuGIeUAXC035FDWCJ3yGPIZaH70fwBhFZtp8N
         NZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFfKfYm0N3LqI8J25elWBtfff5jc/IewGs/5ZXYbR2Y=;
        b=tDWgXhOwobNIVSk4Rb5AZxckGWCF9ZMA/n4TA29ncMYYTmWZTw0dZmJwhHmX83UnJD
         dS3g4mPJkc4LIgqo3d9ab3elZ7QxQKlYp1k+wk5b5PdQcQ//X64jksp4PqxzCDNlsCHc
         L8NgWbXl8SvQgMG7R8OlLKlVquC/v91atlh9GqWFpcMDl9vpruQBO421kU91SH2Gml7H
         +b4e3Myx9JahkK7GHC+opZvRkEqqYELBjthhcUtkLpWqP0e7N/nKh/G6/UFprlpHpd/4
         c52BkHxAFawnXFHaio6iMts2CvG1/yTPoRGnII+GDYY/iSUNUGH3zt70GT3nU87qnUY+
         YHKA==
X-Gm-Message-State: AO0yUKWzdbRp68wOKP9FKOKq2ejDPcZZmCN8HJPNuZ1pmDV+OYOfo2RI
        FMHkE0F7t2svnDMDCWphUFLlSDIkSFc=
X-Google-Smtp-Source: AK7set+RY1Ebp/m623hHdxsxRhKyzketswA64mEzoss9/AfYZunkCdB5cDSdwxc8t78rEGjMAWFzhg==
X-Received: by 2002:a05:6402:105a:b0:4ea:a9b0:a518 with SMTP id e26-20020a056402105a00b004eaa9b0a518mr3351386edu.17.1678183050330;
        Tue, 07 Mar 2023 01:57:30 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fx14-20020a1709069e8e00b008e56a0d546csm5787189ejc.123.2023.03.07.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:57:29 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:51:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc:     cip-dev <cip-dev@lists.cip-project.org>,
        linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@ver.kernel.org
Subject: Who is looking at CVEs to prevent them?
Message-ID: <59f7f076-a9d5-4bfb-a6da-bbe0a7567688@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
> CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
> ksmbd_decode_ntlmssp_auth_blob
> 
> 5.15, 6.0, and 6.1 were fixed.
> 
> Fixed status
> mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
> stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
> stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
> stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]

Sorry, I have kind of hijacked the cip-dev email list...  I use these
lists to figure out where we are failing.

I created a static checker warning for this bug.  I also wrote a blog
stepping through the process:
https://staticthinking.wordpress.com/2023/03/07/triaging-security-bugs/

If anyone wants to review the warnings, just email me and I can send
them to you.  I Cc'd LWN because I was going to post the warnings but I
chickened out because that didn't feel like responsible disclosure. The
instructions for how to find these yourself are kind of right there in
the blog so it's not too hard to generate these results yourself...  I
don't really have enough time to review static checker warnings anymore
but I don't know who wants to do that job now.

regards,
dan carpenter

