Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436F66D3A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjAQAeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 19:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjAQAd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 19:33:59 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DC27D79
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 16:33:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q10so9664047wrs.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bWwcIooOwVnqXU8Na6hMemxJARojcpzDWlR1Y5wzC4c=;
        b=Bl5Yg/uExsm6qdtg+V3HReLEJH+cDkSnieD+MDsyp6Ox1zDbGWzzunvlPNgxJAfnxH
         HADsHf2HZep/MDyLiQSg119Iu8JtGKrjyrcNSg4mzlCK6HweE4hZzBgq+js9igXDiVHA
         dDmZR5n2c5RveiCIPqPSL6f+89hVLYHFpMqwnf4yjIBte9u6iyZcNZ8NUVBOvR/wk/Ld
         /zXlJe7F2QgMqwlyNAWUCJynDBQnwCOQz41CCqOB0I8XcMXxldmDPqTDvtNXoYiRw0hg
         su3slYopsISTJRzFW1st3vdB2W9yJvTsVpWgI8hQYTNdE8h6uJHw1rNeDEcpSL9UvLgK
         LF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWwcIooOwVnqXU8Na6hMemxJARojcpzDWlR1Y5wzC4c=;
        b=zHlp2dGB2JFUaJmZXt5L1UlmDNG7WrCNxQ3eF1zvnrA4pbPmCPNdIQ4b4C1/irt9+h
         2BK1hDM7HPL1tMVCoDChRFS2dkdgXki1d9lYwoHJ5xyX207Jka9WqYNNPR7EZlkdvMhj
         SpgrB0J16B3ccVy1WcvH2/HLQ5ccrlclVVoGulgJW3ED/1hnM3oDGD8wrN75cNY0eVFp
         /TVgjmBwy1uC/9XpxysslNcggRt4g+5DvFkwVxlNnUcxkr01LclxYL+adEgptXJ/9DZ3
         aFM65YMR4PMoPO6N1x68WlHy+qABm1ycJkxa5dsul9NoJpXTsJNZG0uDtTFjVSrram8V
         XWbQ==
X-Gm-Message-State: AFqh2kofNScofblLTdY5xOy6WeNfBviEt26avoLjqiI8UAs7VrlunX1C
        ARJ4ACuqOnM58sS7zERV5yLMB05YQLebwgyh7LJigw==
X-Google-Smtp-Source: AMrXdXt1TTiIRUgTHoD4ZLP2l2jwedzF3v4TCxLrVdYl8U/6juetmaxN2A6gxNS8L3gyR50D0u0xFQ626Xm52V90Za4=
X-Received: by 2002:adf:e74e:0:b0:2bd:db2a:ed3 with SMTP id
 c14-20020adfe74e000000b002bddb2a0ed3mr57210wrn.507.1673915636901; Mon, 16 Jan
 2023 16:33:56 -0800 (PST)
MIME-Version: 1.0
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 17 Jan 2023 00:33:45 +0000
Message-ID: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     nbd@nbd.name
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org,
        mikhail <mikhail.v.gavrilov@gmail.com>, sujuan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm struggling to find these patches on Patchwork, or apply the saved
raw patches to rc4

If I'm missing them, would you mind posting the link

Cheers

Mike
