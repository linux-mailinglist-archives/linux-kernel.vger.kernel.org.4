Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598E06B6C06
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCLWmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjCLWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:42:02 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A72FCC6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:42:00 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id z83so6024257ybb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678660919;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=lZ2VZr+MT0HD+dazKujRBpYfSPknMRDv/QZ7QiPF2rKl7RM8SMrBEzaSBP/JayPN8m
         0PT8HOTFsjtJf4VAeuFOts6oIkrbWvyW7HcS4lx1jXI0K35/92xaDhI0BXdAcSB+Wx+V
         RIbSxuB5+BQGMPmkbs1+2ggxXxw4k0ex/1y5RSdL3NK5PhTZOk5JFAdLEYLCZuFMTjXc
         2uGC5TOkMLVuilduqpKEjWZ1fue5KEsNU67JhKueWnYBv2tBk7XVckO+tPXD2fX5j+AL
         /86zVQxPlhciLRKpmzkkosqy7cfHL1YEW3A7Dlr8y5QfYn+ok9BbiAmQcJZETjNia2fm
         Lqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660919;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZVkFn3YwdxEdThkVHM6Q9Cxc1dE09qwtEAvH/ySM1g=;
        b=FogA+cT0WmpqdGVnKPDnpB8XS5f+CNLCINivHE0s2RMQqPShFFHmgCW+0vI7S6DRkp
         Lywb40XaWWnmlnRm865tWh1pLq3JeqZZI2gmrSWARljsv7Mqugcb++bfGyxFTSRvJmkj
         lxr81HNSFfbC+PROyxuvpgXdI/8eoZxaUGOKrwWvvGGasq7kXYYNQ/JRo2RFwvUQ6Izf
         gFCA/4Lb6cv4DDKQUfqe+nCKRSEFWL7vbL2xK2M7e2UuYBzdnL5XMXhPO0Nc36zBCmch
         kFS/wQv3RniON0NAaX3vwApahn73UcAx1LXIVJ+TPd1H0x6Cgu1G8RYEfKKJQKbv74Ff
         cnQQ==
X-Gm-Message-State: AO0yUKUlwD31aHXeIvQMvE1V8rNWZ9FBZvGRlULb0FDsu3/13rNEQ8Y6
        OiNsm6vB11n8YLehqvyajMdyvRxHLFxGP6S+Y1k=
X-Google-Smtp-Source: AK7set8hvXk9PPsxIlKoG0paeZ0j3kK+GhZiMnV1r2SEZBVMkCm2Zg/Zr5+1aYWuqH2LKQ/2UOnjkchR0y06+qBnHpI=
X-Received: by 2002:a25:9006:0:b0:a09:314f:9f09 with SMTP id
 s6-20020a259006000000b00a09314f9f09mr5710626ybl.6.1678660919406; Sun, 12 Mar
 2023 15:41:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:2e0e:b0:2e7:5912:2b3b with HTTP; Sun, 12 Mar 2023
 15:41:58 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   sgt kayla manthey <kenthlive4@gmail.com>
Date:   Sun, 12 Mar 2023 22:41:58 +0000
Message-ID: <CACHSKTrwb1Ksb2zCRka6WBPPPpiq1-qqDCcGcHCYk4PbugKHpQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5553]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kenthlive4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kenthlive4[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylam28[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
Please did you receive my previous letter? write me back
