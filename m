Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288F55F84AE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJHJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJHJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:58:43 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5548EB5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:58:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a2so1488257vsc.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 02:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=alS2y9ZhkYX/b0cEbVqLJaBg8KF5F0mRyBNHJlRQ0RBTi01L+OeZhCJHyvaP82t8wn
         mNSEWLRX0ezyP/moCxr/A4TKigGa3Rn5DlUXTa0d/E88YJmOVEFcamoFhw6xi1COHUOe
         qM9hF0m7Zud0tmrPicNEpAgCeivEeELj28PBE1JxXUziEmyNvKcx+dsLpiXsk+8bBYZP
         IQUKMWkvLG5lDr3B/23Pn5bAYCho3jCO3hPgbqyJl/Roi+mXZjG+JS4LNAIBVAps8AlA
         TsqNdbWrfQNAp7C/q+BYRvIaoTA05LAnwXDNwoKvwyp3TUl5hkRhhRJu3g1aIqannvu1
         BLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=dx4snMRldLopwsNIdPuE+SouHz1i2mP0m6QZvorowEyc38C4ubuQ8O8eQGfTfDtPsM
         bYHk4pQK06cAyMyYEWZwXdaZotCItiML0g7wyEoIGPSAXYokLzWRzNeWriWC/6oOkVtz
         iV1OFhYHpZSBJ3xjNERA/WCcm6ey5Hpjps9EPbZ+vGPb9HBFXbIzJ1v/vOPMJTZNtOSx
         Co+qC54yJxuieUEM2hnrZfnvsBLnPVEGAO88AfMd2nOL/ZW2Ix2Z8h8Xi4o+k4pQh6tO
         6oj+4NsvKLV3JvO3z2mBq21ZhI6ZtEAmaxdjsXrqGAgkFBi3LE1+ug3908gmk9QatWs0
         UL4g==
X-Gm-Message-State: ACrzQf21QtAOQhs49//DTk0IWf5FqIXEJy2VyGawEbiSoWY6RuaCDgNb
        XCn/K2Bm+0FTGKMH/HpzXQJct0t77yt2pxfJPfU=
X-Google-Smtp-Source: AMsMyM7w6OMd8Jb03d4KgOWo0keOv5a04FMc3KDrN/PkZQCICy1L+lpCM6ZuuO4nsZ3wsGN43O1AA4IizKVeEwrUGGA=
X-Received: by 2002:a05:6102:f92:b0:3a7:6b2f:8c59 with SMTP id
 e18-20020a0561020f9200b003a76b2f8c59mr108797vsv.54.1665223120529; Sat, 08 Oct
 2022 02:58:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:3289:b0:320:3f85:e8e4 with HTTP; Sat, 8 Oct 2022
 02:58:39 -0700 (PDT)
Reply-To: financialdepartment9811@gmail.com
From:   "Financial Department U.S" <walterhuxley7@gmail.com>
Date:   Sat, 8 Oct 2022 10:58:39 +0100
Message-ID: <CAGiYPmA1c9d+uWLBFz6zVgAcHotL5Xg_LP4tOree7fk0NWh_vg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e44 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5024]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment9811[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [walterhuxley7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [walterhuxley7[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear friend,

I have an important message just get back for more details .

Sincerely,

Mr Jones Moore

Deputy department of the tresury

United States.
