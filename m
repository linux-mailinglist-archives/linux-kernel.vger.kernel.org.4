Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB316C5D46
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjCWDcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCWDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:32:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334FC2596C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:32:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i13so10363298lfe.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679542326;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NNJnZYUt54Hh4by/7Hh88dDYIlhh/SOwlD6U5QnzPvLsvAL3Sd7Zs2W2K6UJWZosGJ
         bEKpcECD926/BRNckeW/0g4x6t7alinOQii71j1F2a8uQp3B04a/KjNLgOtbXjPTwlkK
         ligfFH5ETufB7PT67qbyNrZNOqyRwHdWmKsvU0co/zPBQWa4KAwhQLoVei+8y1vA6fSQ
         mvjG8ZYpLDgpmmJhI6SGucqkI/weHi8N4Njek+P+JlzymEogLAOstvTV+H6tOJGoj39+
         Thr7yDKzouD3Ixo1pNaQjFCYVRsSgh5rEB7QmeCUcK3QzFt2KXk0FVKNHeMt6wju9Lg1
         ZVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679542326;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=a0RYI3DRGQraGJ10XwWyYM2rSOd+PqbIYFKnUWty+YA1ytru83xL4TYc/ze7/TeZb7
         kYdFajYqoAYbduI0oNms2CV4qjfL/8n6txbntoVcR2AYHs9G3nkrqtXKgmKmgxPNWIl8
         gch5dIG1cHl92LrmEgF/drGeucOwo16Oq++EbseA1UsrdiLWVD8Idk2xQzV+5HJrJ+IM
         C5sqkNIk3FXGbmE+6RNDBwUIrp58k1UAi/7bLTSmgRazMt6gsTsM261xrmoifFThpsTD
         W6+Kxq/oxed/5WdDI7Gzw2OgaBmhiD6qlzzBaeAQvzYIB2v3bWJq3CK8EvmTVuC04CFF
         US8g==
X-Gm-Message-State: AO0yUKXMN+d6t4PijDlqwGnPfYuP9aWRID5F8KxHlKntxhJIYjvh/Nl4
        vH+GlFf5DQdog9Oy6x3NYrZ2I7hQsf0yZOL2Jtk=
X-Google-Smtp-Source: AK7set/WGg1JMbv08KktHgAC/lpUEWbLMLQH+ox5or5jdZULSHUbxmwzBHALXdJeYMr0lDUnsDThuHAEV81oQB6LG18=
X-Received: by 2002:ac2:4153:0:b0:4ea:dec1:23ac with SMTP id
 c19-20020ac24153000000b004eadec123acmr2553768lfi.8.1679542325939; Wed, 22 Mar
 2023 20:32:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: hannywilliams05@gmail.com
Sender: arnettporter4@gmail.com
Received: by 2002:a05:6504:1161:b0:222:543a:6dd6 with HTTP; Wed, 22 Mar 2023
 20:32:05 -0700 (PDT)
From:   MRS HANNY WILLIAMS <hannyw787@gmail.com>
Date:   Wed, 22 Mar 2023 20:32:05 -0700
X-Google-Sender-Auth: 5WrTbLmYL9-oU66sUYWwKMLIdmE
Message-ID: <CAK9JzOmh56wkMVoiW+q73o6u9SRdTrPxfxAnQVo4a=i+2WdnjA@mail.gmail.com>
Subject: I Am Mrs Hanny Williams, I Write For A Charity Project Cooperation
 For Your Kind Consideration Contact Me For More Details
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [arnettporter4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hannyw787[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hannywilliams05[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


