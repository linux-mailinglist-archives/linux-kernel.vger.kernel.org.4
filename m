Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEEF5BADBA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiIPNAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiIPNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:00:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9BE9A9D5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:00:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k10so35439132lfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=Q0URTlted5oUvua00OsPVDwnxLG4UAMpMxvyNUqDnP5eswZH98Ha9FkWNdXJvksdNS
         cLFeFdQfbMCDWjsA8nKeLk0zUtwfW6kJVbpbDxfsBsZ+a9gmXpetH4YXHV5XZ2ncMfr8
         TIied8S388UD7Gij3iQR7Vt1kcy1bvbdXqi6ZxXha1555NWPU3cm41m/BfK5NXoa+eaK
         1uN/xOM9MIygAREMuxwRwt8c1ACEW8s5JSpwh3iAnd6WYokYNSb7e4a3zxd4n7SsWehk
         I3zb20o/e27LDYiIBbrQo37azREMKNgJgHZ+dvqSn0BhLSh0vAJzW53mmQLVOmBpidsv
         ASvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=L5wWDUyIzfwtx5RMIz2Ly4jPTEmXM7djGXbcKNAtRZtlt9LU6dLz2DD8YrUYWtyWiI
         ATk5BxF4Q5e9uZ5sKtXtZtfTcw0AWjfHXzkaCHWWCvuh2HrKyxfzmXcHgOIVO8uG0VKh
         ue+n0vLNxALzHncD2wRkwmVG/j+bgPTfz+Iis0td8MPAvRX4I9gM3zr8/VKfnWW/qcar
         YORz3qpZSz4PbmHQZx3L3wWAR0DI3vj9EvdF2iOjfBRxW0Ab9VEgRpuaEnKI69f80m/F
         lY5GVw8Sl9HAJUiC0R2DudoSi7NxrzPdaVNQry7aBKiUs/cTWiTei8FIy/a2WP1gsC73
         AU0w==
X-Gm-Message-State: ACrzQf3E9dTBv4Ns/5ZO6a+VijhnhFR4v6aOwtSkhReTl7Rtq/+zmjSu
        nvNMiFSkVjricyeeCTGUmhekQjQho0k8BlHnMHw=
X-Google-Smtp-Source: AMsMyM44yKtfk+kCQwBi8WzxIT3ePBFrW6wehO9h72bPVEDCKjKlMscmTPZPReH+U0oXXZbiYn96WCuEEk35o7RcThU=
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id
 g9-20020a05651222c900b00499cb5dc138mr1619325lfu.490.1663333236624; Fri, 16
 Sep 2022 06:00:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:334a:b0:21e:7225:5daa with HTTP; Fri, 16 Sep 2022
 06:00:35 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   john mark <johncp5547@gmail.com>
Date:   Fri, 16 Sep 2022 13:00:35 +0000
Message-ID: <CAEvS9HGKECuzhWLJqj2Bo448rRGs3-kdEBqvF7KNhJF7ghZnLg@mail.gmail.com>
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
        *      [2a00:1450:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johncp5547[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johncp5547[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
