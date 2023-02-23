Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7EF6A0BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjBWOce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjBWOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:32:32 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE37B5504B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:32:31 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so4998430pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaMqDHN3oP59SeecnXzjEzLcMckfM+kngIRUg1YYcp8=;
        b=FNDumH+awo7alSZBGxNmqskLJECyqcqYfwt38h9JVzQRpLgpQCWuIwODlZrgOIm+Ud
         1IrHAuz2xi+v0nAurQPs8W8SAWRZcbqmW3lFduV91v7MlQ90Q5cOQGmguz5wlpKOLs+P
         czx6BBjWwYbQ8WSW9iCGiaUTJCM6NMlOkgHeVtO9nsIIPtReeMvorBPPyYCzhad0qsz+
         BKiW9+UdggYWlwKTAv/p87OHtiJ5RwGpPziS8ly8Io07dYfYxBBv7OGcZUKtMH6AsJIj
         3vcOBo750jcsAiBy+o+2KVMd9BamIp2k970tiyNRxvp1+nY02Y3itjl7bTkIgBknUCp5
         3byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaMqDHN3oP59SeecnXzjEzLcMckfM+kngIRUg1YYcp8=;
        b=qci+aC3Ndod4sEXVaPNXoB9tktJl/I6dPhyrCnlLqmiejPVSWkNZnf7ZcrNFABPhJ2
         eZDsXKFY2HC4GDpCw9yYAopZTLir2HISVDyh2PeNESnZzkT2Fj68vpgvXPRDyQYiSfmA
         CTCBMjfv7h1okNDCFFTYPiVxhn2Twm9OORTVk45pYaCrJwd8Olk189D5wtJN2JaltEKn
         rjUMBEAMswov6ufmbnboE1Xtwg0b6Q2+/fwuRMCW1f2HINB1feQakQKFjRjgU8iiAjNO
         6kCJZEm8nRnao333qoMx/+pm0e0JXXXCoYYNxB7KyxWY4ds7kEG9JXisRQJSRVJA93z9
         U+NQ==
X-Gm-Message-State: AO0yUKWZzF5UPraWFszdhoxBpcP7itX/xWrtnNeuF8wy4Zd3cZvHWQiD
        0E5NcLoUjDF6ddvx9tUyzSjt5p+AMOD5X05csSA=
X-Google-Smtp-Source: AK7set9M3DFARcprXm5AzLJPUZwt1xJSTNDwXVmjJbqWcyM3SXXFDod3QSAFQXCXuLDnEuGLXZD++2NA/FD2gy9zjOQ=
X-Received: by 2002:a17:90a:db42:b0:22c:89b:5a8d with SMTP id
 u2-20020a17090adb4200b0022c089b5a8dmr484873pjx.6.1677162751096; Thu, 23 Feb
 2023 06:32:31 -0800 (PST)
MIME-Version: 1.0
Sender: zallaabdoulaye67@gmail.com
Received: by 2002:a05:6a11:939a:b0:43a:2e4f:f8f6 with HTTP; Thu, 23 Feb 2023
 06:32:30 -0800 (PST)
From:   Mrs Suzara Maling Wan <mrssuzaramailingwan12@gmail.com>
Date:   Thu, 23 Feb 2023 15:32:30 +0100
X-Google-Sender-Auth: 7NxjoRnOLCHGCyQTOr2x0WrL0Kg
Message-ID: <CAKOZ0bRxw5OSGGvJcYwRw4_iEW1bgGAz55G16yq21-PFAm8gYQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Beloved,
I am Mrs Suzara Maling Wan from (Philippine) but based in West Africa
Country since eight years as a business woman dealing with gold
exportation, I have a dream and desire of building an orphanage home
in your country, and i have a deposit fund to the project, but
presently my health condition we not allow me to carry out the project
my self, now my doctor has already told me that I have just few period
of time to leave because of my ovarian cancer disease, can you help
fulfill this project
With kind Regards
Mrs Suzara Maling Wan
