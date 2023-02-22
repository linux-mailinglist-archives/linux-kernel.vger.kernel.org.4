Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8954969EC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBVBDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVBDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:03:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C87D82
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:03:08 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so2319513wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwW09HLowKxE5zatdP2KBq6fkDP5u05ZMDoPWMCmDjs=;
        b=hM04A5vvSx8+70QpudyPyClrKanemyJdi+vMM14pdYdud/zOgrwBzqju/QiXm3XVIB
         0fZxQ0IZWu2AwhZSpWPsfX1mBcKRBjsK5TxN9J+hw7+OVp3bFWEmvhfHK7EFG4g2iOGq
         DhakemcAr7msnrCmmidwzzqYnTh9rv1PelBIAdAVrzN6UdJtO0e4RRfdH+YqvSKH9HwD
         n+gQyW4sxRtNvfu+hIj32t0RPaYs8aC1+WgDy8a272G+SqPw0ZKfbYkfkCr+BBgr1kQH
         LANI/4ij5hrVJDmIuSmujTPcwq8L1E7Yg+/IFRqfkbSb2R5MJKtSj8AeqdaMY+VRTCic
         9PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwW09HLowKxE5zatdP2KBq6fkDP5u05ZMDoPWMCmDjs=;
        b=KdfTdLH40xPxR6XibNgqprXyCuoHyl3NoFGIRaFx+OFk7oueJP6t06fqWQi6XVEvIy
         XSA/3aB1OEO/hknoit+yArXSmys0ScV9kNxCmfdJtacm3mlPp/Ch1YZ5m+dh8nNEkvc/
         2F9asonZZXmZZ42ApJl9ROPvEQil+/3zf2MEq0RCYI4pdmcBTZMCzlypz3FHtoQ8b64D
         ooFCNyQE2M4TWRfgCQCZ9wMykE76mtv694TtU2/nhxyz1q4i7kDUzNTnsqyuRmkkI5be
         zxKJFtNGrkJ34/yioiQMl6Vl90+3DF2HXKDqkg0rCEFlCxVBxXYBtfwnpRoCa8Olie+i
         U0dQ==
X-Gm-Message-State: AO0yUKX6m20t6qvLbNZtwYL1SV1Zt8CTDh9r0iDJqQNBxx0kNPcTGhEi
        OLA2EyWx+aC7Atj0ydD/3J3YC40EhwOKmmAOJYc=
X-Google-Smtp-Source: AK7set/4gj8Nc9Uyq6ODr08AqtjOvWaeJ+Iovfzre3sCxpLo6IhAdTt34ZiwAZDBzcmUZBqT3ZbeZhNIe3+JFiOzI2Q=
X-Received: by 2002:a05:600c:1d10:b0:3e7:772d:22e1 with SMTP id
 l16-20020a05600c1d1000b003e7772d22e1mr288756wms.78.1677027786734; Tue, 21 Feb
 2023 17:03:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:c791:0:0:0:0:0 with HTTP; Tue, 21 Feb 2023 17:03:06
 -0800 (PST)
Reply-To: geoffreypearce88@gmail.com
From:   Elizabeth Fisher <elizabethfisher856@gmail.com>
Date:   Tue, 21 Feb 2023 20:03:06 -0500
Message-ID: <CAKEVvGU2XdurE33Lc=YU86huCCOeG+6ns7992DnWjcFZQGAL1Q@mail.gmail.com>
Subject: Kindly Reply Is Urgent!!!!
To:     mkpdec@hotmail.com, harman@privatemail.com,
        g.cameron.beasley@gmail.com, brendamfindley1017@hotmail.com,
        test@xlinesoft.com, lizzybethng@hotmail.com,
        carolinethami211@gmail.com, samantaurie@gmail.com,
        bkrippner@hotmail.com, dutt_sudhanshu@yahoo.com, Raoul60@gmail.com,
        Bogan@hotmail.com, aaroncfrey@gmail.com, amyspeich@hotmail.com,
        Sweitzjls@gmail.com, Molly_johnson01@hotmail.com,
        minzheer@gmail.com, fanyong0413@sina.com, yuyang5012@hotmail.com,
        kspriyaranjan@gmail.com, priyaranjan.ks@hotmail.com,
        ethantextile126@gmail.com, hinapatel80@hotmail.com,
        ashleyiverson1014@hotmail.com, gravindraravi362@gmail.com,
        klyu92@hotmail.com, aidanaadhirah67@gmail.com, aaa@gmail.com,
        bbb@hotmail.com, cptapartmentsllc@gmail.com, tcheng99@hotmail.com,
        redlowgypsy@gmail.com, margikeys93@gmail.com,
        robesther@hotmail.com, bjsauvey@gmail.com, kdogis@hotmail.com,
        erperez54@gmail.com, paularose2000@hotmail.com,
        ken_shead@hotmail.com, rjcareless@gmail.com,
        Rbdunwoody72@gmail.com, mmwayrob212@hotmail.com,
        jojobakasi2019@gmail.com, srandhawa5@hotmail.com,
        rhy3756547@hotmail.com, gab.dark.100@gmail.com, pcerio@aol.com,
        stormdragon2976@gmail.com, linux-kernel@vger.kernel.org,
        KS6vdql2pIsCiI@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a business proposal i have for you , Kindly contact Geoffrey
( geoffreypearce88@gmail.com ) On More Details About this offer.
Thanks
