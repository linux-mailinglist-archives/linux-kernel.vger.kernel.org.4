Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6A6B2C29
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCIRii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCIRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:38:35 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676592798E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:38:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ay14so10053627edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678383489;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCRUBSFWfUJdlaStN+qT+zl8FTW7qoCRSrif9+SCGaA=;
        b=k/AtuVoiYZrV7ZU/C7viScRakJKZYrXmaWHi0xJhRwjc/tx9wiSKYhHTnCK+bOQ3vM
         gBR81ZPTFaNu1sQYYUnLvgvmcr5hnN1tGCnA8pAQfbpTDzT7WfWYTcy2bzeIW1sLObD8
         gD4o8rQgaxOTHtiEBDBiKDgF3Ihhj6k4NxXU/thIGWwPOKXdflDpd7wIPmIbGosvO7IS
         T7laQeMqJ0cr9HID1hs+sfP+rk92ADXWrg1kC+s2F6KCuODCG2i9waXHxHmHJCmwrgHH
         3OxYfrPUrySB9cZEmM8W3TenVx4DqJvnfK2bsmTU4E1HfbFFXCxfREjTxTowU42lva7Y
         /GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678383489;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCRUBSFWfUJdlaStN+qT+zl8FTW7qoCRSrif9+SCGaA=;
        b=nc8r2GE3tKY9LbQyJc7kAq1b/jzXz1GNWhSvL093ozWG6TwZQdM6f2WfkuKhM0eAbe
         jh+/Eo+vLPdnDoVCBPIsSRkWRGcn3V6GZnBoO6Gp5+W6gJdrZ/i4hqSEdQ5hxd2GbCdl
         TLy+EevKQ5bzwjE2pcYCCrDfGVLnCYPrPft3Fj73jpJINHFyGBl7V22rolSvjjosHgpr
         LNKXAJeNPMPjM+/Avviw9Ss3yNomtZeTT49tmymfk0NI5rGW6UDIj7mFangpeP+WBk/R
         HXKm/JyKivk29YUHmo+Ug5MtFWUZyyGpCJbJ6M01YdrpxbU3ByYFRIoGnZuFeR9i0prO
         h/Jw==
X-Gm-Message-State: AO0yUKUYZ1jRggClniUBrICH3gL7a6wnitRVRhFOg48VqMiok3m0RZz3
        sH2hpOoHrHK6qXSEywlAsGU7kBmAYBEWQCkUrJc=
X-Google-Smtp-Source: AK7set8JsKDvk5YYe/dVTkAz5f8Zz/ne4zx2i9zkWmIgW+IH9xu5K1JOUNqmx/fCFYhm0VAjGojyDjL32pz2P/aY1tI=
X-Received: by 2002:a50:8711:0:b0:4bb:d098:2138 with SMTP id
 i17-20020a508711000000b004bbd0982138mr12463686edb.5.1678383488557; Thu, 09
 Mar 2023 09:38:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:7f22:b0:89c:e54b:27a5 with HTTP; Thu, 9 Mar 2023
 09:38:07 -0800 (PST)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <luben8213@gmail.com>
Date:   Thu, 9 Mar 2023 09:38:07 -0800
Message-ID: <CANyAdH_5DSTFRvWxGpZS_6X6K=AFZnBKcwN=575XkQB+S7e4bA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6214]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [luben8213[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [luben8213[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
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

Hi Dear,

My name is Dr Lily William from the United States presently living in the UK.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

With love
Lily
