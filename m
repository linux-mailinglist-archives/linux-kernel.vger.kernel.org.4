Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543D6B1683
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 00:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCHXau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 18:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 18:30:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B382721A24
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:30:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k10so71830edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 15:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678318246;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XRPBBddzeTT8bZfznkWkeWBiYhSwSclbrd/MIeJUPxJfDAt4WSuOOQSRt0czuVZ6qE
         tx1OvLpt8nA6n29afi6qDrF0U1J+P8MPH6qi74gq/FsVNAd/uss+Xn7XxlpB1ykLzwLz
         4xk56zLayuDyYSRdde2HMSOJwfhptRlk4WnQ/RX/Cp9SHTXo5ucxXdSvRW0VM1xi5afT
         KBWpmQbTFgPHqUkP97fstH3UmbqJaqMwyUYtXeErN1A+nZiO3zFSusgsg1Ri4vSg9qbS
         zzZP8tIyYanT+9f1IbxN31m0kIjz1mAHtu/JFxtqBVETC4a/yW7jcbeMizQwdZYp2DzO
         PjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678318246;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=KXVnghlfeKTuYnYjv4uzKW9w0tu4QP40KmdtH4huoJjYiYBhWNt7xCMj1SrPG1DHbK
         lLHarzHHz2d2BqsNh3BAAt+ktv52dmF2tFzIP5I3UF2xjzpG5rV1geYFTrzfwtmMI/pg
         vHiczShCigzpBDtGG+SQWJreW7ULMECPxa3QZ3lY4TNKcC+pKXvIyRvMz4zqrFV6d/Du
         J78ulJMz68FmEmWvcKOkRAO0AmBbTvDlsW/RYDvn9P/QdaANf9d+IrdJnoveWMajuZ4y
         BZY6e7VrfsOK0XyxASNlk02qWe3zZdfTGl+56OugkIudh47Dp/Yo/jUURb2RRByPSxYN
         sxaA==
X-Gm-Message-State: AO0yUKXrIP4m7Ri/oqZS7zxv4GCwTb7PrKR8t99bBdLkdZ1Yzs3GoFuO
        7Wyj7BIUGDFjDuYog4uYfMThFh1oqLi/PiAyII4=
X-Google-Smtp-Source: AK7set/qBQw1xVu2B1PUjnp7x+n6ncdAtLJyv/VXZB8TQvJm9hqUEhTX3eg3GKNO3JcVNQEIM4CFwsY2uOmj5mdAF+w=
X-Received: by 2002:a50:c04b:0:b0:4ab:c702:656 with SMTP id
 u11-20020a50c04b000000b004abc7020656mr10868787edd.1.1678318246084; Wed, 08
 Mar 2023 15:30:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7208:c597:b0:63:ca1d:124a with HTTP; Wed, 8 Mar 2023
 15:30:45 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <usdepartmenttreasury63@gmail.com>
Date:   Wed, 8 Mar 2023 23:30:45 +0000
Message-ID: <CAAkzHO_=gMY=ErxhhrreSTtU8X9cyJ3O+GSg0g8sMeuzAVSHAg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6428]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [usdepartmenttreasury63[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [usdepartmenttreasury63[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


