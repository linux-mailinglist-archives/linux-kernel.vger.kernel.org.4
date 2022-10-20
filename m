Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0A5605E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJTLBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiJTLBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:01:03 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC5B15B13E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:01:02 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by36so25818548ljb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyBUuslthV1iukz97HjUzwRbU5DGVBFIKN5W8BNvfbc=;
        b=KL9selRsjGQMqeAp735iVBdW5FfEC5WZ6RWYe7yFBHmxo5pyZdg0khgt+p3RoBGnXm
         OMwgaHe5r0beFOmWCG/+QrfAcLa2j7bBEwtVBYoXRlVfQ1O1msL7cvJ+xgrIlfdfa2NS
         EWdBsrIXdjr230NPeIkLDOU7kdzVI7DdlQbcpmtI1Z7hB46pk6m8pMLp7E5X5z/3R+VW
         tEmfZnfkitqRZdyFLY6xwziWxMFJBgwp1j3m1eley+7ryXTHUHvDluoDb6BgpDYwygBi
         eKiI95MdSWgXqgjzCQFBNvCoPp+n3NPHe+L8GhlPpQCuKvv0YxVGVhidc0VUuCFo1YnL
         YcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyBUuslthV1iukz97HjUzwRbU5DGVBFIKN5W8BNvfbc=;
        b=7/nt4dSw/y2QjfaMFRe5iF0+DxjgLMVKtEhS9xYPM0Y2PDop4We8Y9XMtGPcY6X7Ha
         I9SEcyHyfzU8PCrcu7/GhyUN7Ds4EPNlo4DDvenYcLzrYj6F1ZDycG6qWmswVVyBQ9MK
         vb+VrKuzsdaFXNsSiShnvZrgT1mWLaAbtoS6U/yMdRKaQ+ZQHJqRHtvfUconvTinQHKp
         v7AdNc323p5UkbLb0jjt/8wvjp//bQeTKMAzz5eToa/5Fb12JwQ8ayty9y1IIFsicun1
         k5C9v2OL2oPU9SZKoUCiMuA/NYBsH5g8PlRrNG0/ku6B1Y7xdSH3ASmPli+wBfHLAuU8
         OjNw==
X-Gm-Message-State: ACrzQf0f+43ug3rYG7C9r6J/q4tjyBjlmF+fH73oDVOYjN/1nWsjcFIW
        HcNNatmQEb/4uzcPZes/Y1I=
X-Google-Smtp-Source: AMsMyM4pjUdJKKO7wtjGosPyHWL6LBIOThxgqwqxcVch8+HA2lbCyUsk/Rdi/D9OO0i+F2FAJEGsWg==
X-Received: by 2002:a2e:b88c:0:b0:26f:cbfb:784b with SMTP id r12-20020a2eb88c000000b0026fcbfb784bmr4776944ljp.357.1666263660991;
        Thu, 20 Oct 2022 04:01:00 -0700 (PDT)
Received: from elroy-temp-vm ([20.240.130.248])
        by smtp.gmail.com with ESMTPSA id z22-20020ac25df6000000b00494a8fecacesm2676152lfq.192.2022.10.20.04.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:01:00 -0700 (PDT)
From:   Ubuntu <tanjubrunostar0@gmail.com>
X-Google-Original-From: Ubuntu <TanjuateBrunostartanjubrunostar0@gmail.com>
Date:   Thu, 20 Oct 2022 11:00:59 +0000
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Request for assistance
Message-ID: <Y1Eqa7uKB+Wk+Mb+@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have a diffictly deciding where exactly to split a long line of code. for example, this line of code is too long

uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);

if i spit it this way:
uCTSTime =
        bb_get_frame_time(pDevice->preamble_type, byPktType, 14, pDevice->byTopCCKBasicRate);

It does not help as the second line is still too long. I considered doing it this way instead:
uCTSTime = bb_get_frame_time(pDevice->preamble_type, byPktType, 14,
                                pDevice->byTopCCKBasicRate);
But i did this on one of my patches and i was told it is not advisable to split a line between
parenthesis '(' and ')'

how can i go about this please?
