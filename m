Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B94614D13
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiKAOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKAOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:50:18 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA5559F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:50:17 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id m18so7216375vka.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H70IfJkWF7BS/OYUjdUGSfJRgXLtJjyIpPUzLgw52xU=;
        b=kkdx4il7KMHhpUa2fQi41MoysbRavWDGXi2WfgGB9dBknYHzM5TVI/ifkypaqW4AcT
         sYKBik4Ws7L8bpJUXSM+LC/CKnFiMaRNGbYx91NKfOLEO5QenXFvgbvIIJCow0yfCZQO
         hrJNa+tZN2kLMrqk76qKiRqBLIMRMf3FDIMyNZ3nj6aBQSoKT5NI0t+Gkl7pabFyx3Dt
         RtAWSWui5v4/uCRaI+GJqs1W0Xd6bHhlqwqT6QMWWyTfAvkx9AuHMM6ezX17Sevuiya7
         iFs+al2M8LNbOd6nSstLXApsBIu/wI/q/Lxh1pnKW4unFHv/Gej2EkDQn/CmCD7l9BsD
         FtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H70IfJkWF7BS/OYUjdUGSfJRgXLtJjyIpPUzLgw52xU=;
        b=YXaNMRE7xoY9JQ0UKB4K449eEbKNGcpzm388UXPZG1sIkmPafd3HHDEOrAS7uaB/e7
         n+LsS+7EMmH7SXLiI/B68fqHp2qw+NzIn31ZYbxN4f3jHCEK+yBxktuX2fJjFqHDg8B1
         2IE4pOnrawktoNKWA30iugsR3JP5Z5ERq3D3syCsOF2dsaiaDN240uMHxc0xsZf0MD70
         6S9SWMmHwg7OWA0fjuBU521TM7+vxtNxYhMSqo/BLadP/D5NfXlO1paSvrEJkhqiUE8E
         wimM6kGuQTBVuWnJnqWVW54LbIdiwAjGdRVGOS1YIpmZkgxA1XXiovtFFRebxBaxyC3J
         cH0g==
X-Gm-Message-State: ACrzQf075eaNgOptbBmeOm1lDO2mi3bVtA40cMTdciy5doYAJeBCc6TU
        kXeIWgTCb3oM8hYAoLSz/WWiGnM90cHrYCJ1TQ==
X-Google-Smtp-Source: AMsMyM7h04phimz1JSyZtPVl0QYJ3eR5mQcIXO8dAJfH5/+dIbgINyyqDjRMLtTwhV2h++i0HM52huvY11ySnAZIVe8=
X-Received: by 2002:a1f:a34c:0:b0:3af:18:ac1 with SMTP id m73-20020a1fa34c000000b003af00180ac1mr1586028vke.19.1667314216716;
 Tue, 01 Nov 2022 07:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6d84:0:0:0:0:0 with HTTP; Tue, 1 Nov 2022 07:50:15 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <lisawilliams0044@gmail.com>
Date:   Tue, 1 Nov 2022 06:50:15 -0800
Message-ID: <CAAGOrtO1i8bupTrerbPToNOc6yf02KgaDG4dxLS-kh26_+DxrQ@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2a listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8359]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lisawilliams0044[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lisawilliams0044[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dear,

My name is Dr Lily William from the United States.I am a French
and?American nationality (dual) living in the U.S and sometimes in
France for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
