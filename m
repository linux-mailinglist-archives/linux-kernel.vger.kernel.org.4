Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1C5EEE05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiI2Grn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiI2Grk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:47:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351512DEE4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:47:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l14so771949eja.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date;
        bh=k86UqHM3WchRgtW7PvceQFEbkD6R7toG3Vm8zGKJivA=;
        b=kSu2z906T9cfvu+dKrcW6WxBzvtWKbmA+y7giR1OEuLETj6tpiB6m4mvxMou40+SvL
         gSMk9ZhmsHrxZ19AyZNb4i2frZulPTXIdqJIEdQi5jR5W37ET2bNR1bqVpeR8U6Ny5M3
         eBJRCJwdroKqvSkyX/ZLpFsv+K3zkYYx93eIFgnl+efIcZfrNV8bbzKgIaLsCyzmOBUo
         5S6lYOG8aFT567PRQYDIpJIxmj7OAk+OZ2+mTBroF/3JX2SV0Hl/Ev3ipOt06JVUQF3d
         nbv5l5Kbg2jmiT+wTrO3hOj1cKjjnP/jHCcIpj5zr5kcFLWvCbF5x0XOn47uNio218+3
         Da4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=k86UqHM3WchRgtW7PvceQFEbkD6R7toG3Vm8zGKJivA=;
        b=YXim3tRSSsd9fx1xiQFOLO4j/8FOevJHO0UgW8tE07vIHXvA1oJLw/vsvH8v3NWKlR
         x5WMGnhwsrvVOyhwTKEofaLqdQLoUkAHkuaMshuwR07hHbOJ/QL5/Xk+iteldGen8Ja/
         hjLx7mVWcpp0qzddWW5QIYouz6Eahre/Z+tTkQKrbNEe+wvSCvOElaRCL9VWFlT8nI4k
         VXZaokIAmphwVyNdCeM0ODayHdh4Q2fzY2hJNMS1OcSB8p4VsL+t/jotNZoXKB8NVYp/
         efwIzba3UEmwMo2c4mYUUzst52W0ziSNAUCTGksK95wjkjO5VSQk3tDXlP7gar8tTj8S
         vrqw==
X-Gm-Message-State: ACrzQf3pnaLSDf2AXXdwsLi/WuQJQ6G6PeDE+67Mx16JNLcHM2xFsxoi
        e24Cgc5BQvmDhfIjleUNMWLkK1bAbu/CbdDLP4U=
X-Google-Smtp-Source: AMsMyM4rUzgr1b+ehVqvhLfcYPLNXsun3CiuPShYmV9h3evVIG18qhr+HFb/8hsptothwH6/M80F7ebGLy8AQFY0uvA=
X-Received: by 2002:a17:906:4ac1:b0:780:3448:ff06 with SMTP id
 u1-20020a1709064ac100b007803448ff06mr1419768ejt.403.1664434057375; Wed, 28
 Sep 2022 23:47:37 -0700 (PDT)
MIME-Version: 1.0
Reply-To: bshambdh1@gmail.com
Sender: riggsbeal2016@gmail.com
Received: by 2002:a17:906:160a:b0:741:6768:2aea with HTTP; Wed, 28 Sep 2022
 23:47:36 -0700 (PDT)
From:   Sakimoto Mayumi <bshambdh11@gmail.com>
Date:   Thu, 29 Sep 2022 09:47:36 +0300
X-Google-Sender-Auth: x6qK3scof5e-6cpDr7onl26TCgQ
Message-ID: <CAAvtDjkMRXra4DBvOApi=thhMPRe3-KOxh0axGP_gHqjLxiiMQ@mail.gmail.com>
Subject: Mrs. Sakimoto mayumi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [bshambdh1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [riggsbeal2016[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [riggsbeal2016[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peace be with you,


Please I have something very i mportant to discuss with you. I have a
human welfare project i want you to handel for me, Please reply to me
as soon as possible.


 Kind Regards,
 sakimoto mayumi
