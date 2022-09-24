Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1415E8B49
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiIXKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiIXKCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:02:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238D220BE2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:02:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bj12so5087196ejb.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=JEvYgDQ6no/+YZvEKAQ0GMsEMOp3CP6ZoRnLTLX/iIllVfAR8eFe8qU0LIJ642eAfW
         bsOZzAOhm1z9pkOnPEILpunnJqIQp/a1GdW/f8vBI8IWmLpTyr3rBkAOGBjmB2A951W9
         NTC94ka8pEqe93kvoYUaiqFOWUaFD7qEm0e6w04nRSLz3wDss5D+kv0skGDSCCKW5edA
         AJYBqx560lokcO3ZSH2rCeOoGh+mT91FNBaQQmMv2DcO/M/+crzIXIT0t54cQ9cqD1VU
         jqeorq0mqRrJMm9avhqZ1W+lc/G9GpCubRW4xZgXLK1P5JMUfJf0sPz7sYiZjJMyiOI+
         FR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/bzVap7w2nbpPLUVaGrgo7Id2TJpqaHDpbbBhcEalA=;
        b=DUn/YffZmbjgXTG4wl79HnG7OR+sz+uqOhpRr/BVbn5wEnakZqDu3ZuZZKSCP56Ie/
         VX/8GOjzkmktkfFKwVE70iS3WUZ/Bul4ESe/zb2GTm/OU6iVt2DXqXvsoQ6GoDRxF7RL
         HJZLN732P5ea6vR9aEMgYIO70oLuAu0AccFZJxR+HKQzvjM84UswXYEqXg72wcTcG1jT
         2gxDcd+Rhqtu+TRJca9nfPVbpLJYXhdZrNrdc75EZgpnq4Ki7oVsvOL93mutnsVLuT1d
         7Wq5S1fI77msg7J48OF3s+MkO9dW3/W83WtLg3CEc6tUeoD6rWcZZLTCyHJisiYe5sK2
         ZMJA==
X-Gm-Message-State: ACrzQf0hQhTugLcZbXQ+zrKCNuSQuMO1xVsVdohaM4cYYKWAIQwZghH9
        1qeuR+IzRZcQCkfqnJ2SA6/YVBkzgHYFBTPfQ74=
X-Google-Smtp-Source: AMsMyM5EZOMIkmZbQ7oisfJZXCIF5IVLy7wBqLjSUhN4rTToilt9YesDiS6eF2uq/mvgL41AD0POpIw5PFZOijmL3xQ=
X-Received: by 2002:a17:907:a0e:b0:780:72bb:5ce4 with SMTP id
 bb14-20020a1709070a0e00b0078072bb5ce4mr10563513ejc.234.1664013760800; Sat, 24
 Sep 2022 03:02:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:7204:0:0:0:0:0 with HTTP; Sat, 24 Sep 2022 03:02:40
 -0700 (PDT)
Reply-To: daviesmarian100@gmail.com
From:   Marian <donneamegandjin83@gmail.com>
Date:   Sat, 24 Sep 2022 10:02:40 +0000
Message-ID: <CAGj_j3vv7OVMpz=UsZq4uJxF7DS_Gz4Ct=DJHJZPQVNi+s0EAQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [donneamegandjin83[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [daviesmarian100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [donneamegandjin83[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello
