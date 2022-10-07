Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED645F7C26
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJGRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJGRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:19:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2344D019F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:19:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id u21so7925235edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=EIXxWs6o9JhyGPIfdcMizo/WFJJTS4QW32w7U1EE4MSiOetc8zsuWf3rAtQZvNY5Hh
         1jsTUVyKUs7gnyN/389arE1mNFxbyBge54QYj1wLmr1XM3QIr+Ybx98cxScnjTjzW4hk
         jAfcDozf5xGL6TqPpwy2kdxvzhZNrb+kWZ5fu0MgTrTXuRRMNt2SKNaXFWlG+613yvlb
         eZYoMNbwd+DwedjtlIs6XM6sR/w4WSfHT2I1ZIzdyo3Kz/vbBeRzQFLhbeLKPXvw9cDR
         yjTAjv79hGAzoLuI3HNNNWr/MP00RHMhB1y2JrruXVVW/ShMIkm780nGAYFQxS8AGsrw
         OenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7t8yKUhnw51esVO0cP0SMDySLRVgCalW/fw1JsiZpI=;
        b=1/TN6XMI22JEaV3au1TXvBXlGaQz8w/LpHR6x0S/y75Sc17aeFUTFiSMeU35ieRyrq
         mlYuwF6rIqGb1kwgZraAF7JQsXl/dzAnEfPOHT+IoyVSHZFkzQwNGSOYpKdycodLS1tp
         G9Hdu5A7LGPb69Gvyjpg1HFz1jL2AVk+28caXh8W42oqYGzSbyB3iew+Rlc7LuUdov7K
         iewssXQ8YAIHaoC2eV8xB3zsw/UiBAg4FuOEq41PJrV6ABViTWj57ZnzNi44cM5JYGZY
         PMeofP2or0jk+X/vlc5CGZGAcPn1tvsoNAa7Fu58rDC5J7hEQhsakr7yNR0dV7otfga2
         C/7g==
X-Gm-Message-State: ACrzQf2J7j/QC/+DfjSktrxcfQhLrnDXp/vbJBdhtn7Xn3QUF3w6G4m4
        gJiXFjtOSOhqlQlX98lwD6RpBWkgxJb9p2E/SoE=
X-Google-Smtp-Source: AMsMyM4ZBLKgE0iyT/xUpgnTCc1RrnORX/D0YhSf75eCPuraon39tD7kBGnSUn9+i+mIm6m+g+QeNewajr1Zd0Iu42I=
X-Received: by 2002:a05:6402:c45:b0:442:c549:8e6b with SMTP id
 cs5-20020a0564020c4500b00442c5498e6bmr5537774edb.123.1665163144374; Fri, 07
 Oct 2022 10:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:620:b0:25:2ff2:c39d with HTTP; Fri, 7 Oct 2022
 10:19:03 -0700 (PDT)
Reply-To: financialdepartment9811@gmail.com
From:   "Financial Department U.S" <oliverarthur816@gmail.com>
Date:   Fri, 7 Oct 2022 18:19:03 +0100
Message-ID: <CAJQB2e=_qi=_V_Fk-2LJNwYvVVt2N2V1MBs6CnJ3oGV4uJBHDA@mail.gmail.com>
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
        *      [2a00:1450:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [oliverarthur816[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [oliverarthur816[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment9811[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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
