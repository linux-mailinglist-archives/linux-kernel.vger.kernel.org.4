Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C286F9F24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEHFij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 01:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjEHFih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 01:38:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD7A245
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 22:38:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f13dafd5dcso4476485e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 22:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683524314; x=1686116314;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Q0yXVNqgTQGYZezA+7iYk6YNmq/xakaKCPu0doEqgAJg1mlwnSDYf+H5SeQ/Mm0hwo
         jN5a+b/svbZHOCheMkhCw/c+D+UYEMobPai8PUaPSvf93n4nD/u45gZvSeZfyjBMIIr8
         rz26He5YGEFDzqzcyvinKRSM73Vdjh/Ry2hdVLlJJu+I/LFvWJ9H0zvpyTX+Dw6CpGYx
         PScTbfOW4QLG5Vin8+DJxPfIJYPjmfmH8bkQaJ9tVGP3VNQK+2hjBbWVvLo0cqM1OIWy
         SqvZSG8T1vf8HRcJxt//LE1j00721mh8Dc6T501KvQX3BH7vKjkynfBIQO2wXVOZem45
         MTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683524314; x=1686116314;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=P6xyBPAlgFFS+Cj+YncTWNy7vn2hw7Sh2jVFU/sCmgvl+ZrXshwu8ubKVCG45mndcF
         RiWubkc5rM6UvrO+SSCeRTa+JHQ7OVQm3qRXtSz7njvmG8rMYdGpE9GSsuQrlhPMEH/W
         02WRR6BN4kPVDBUDs20+z8Bg0O9banYx5OCRbpUbtNfeVhSTOPYQPeZkRZPL0O8yTigf
         lIKDSm2dV0OKmX37a807eUr0hHh2SVc7ClLTNLol2P3yE/qLHP20OdkVFwOR4Vf/eMs8
         Xl4/Ht5NdrbKZ8zyjarntr5TNOuYzlBkyFetGeS8qYrgvkvKgMVy1t/Dl6sCuzwNCij/
         Q/1A==
X-Gm-Message-State: AC+VfDzOgUuG7EDHXOaCyRyEXAkhFlNzrRBbQggDlAR5EcEf4x9WQxlJ
        o8a9VsiDtpzdcUQDidyi9NHaqy9/BIp9jfuQsdc=
X-Google-Smtp-Source: ACHHUZ6gxEclbczMhJzlgM8Hj+UZFzQvbH4iplxC4k0eKDzDJ+7qkQCnKmSfLdvNIELvoTAWbgyObtz+jNNMUXJ6NTg=
X-Received: by 2002:ac2:4c30:0:b0:4f1:3e97:4486 with SMTP id
 u16-20020ac24c30000000b004f13e974486mr2133175lfq.57.1683524314234; Sun, 07
 May 2023 22:38:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:b0:22b:110b:5d3c with HTTP; Sun, 7 May 2023
 22:38:33 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <teewe45@gmail.com>
Date:   Sun, 7 May 2023 22:38:33 -0700
Message-ID: <CAEPmxYfcB1LciLhSYFW37Ux_kkK_TxGEYV2wiuAaMr8TOjCSZw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4857]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [teewe45[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [teewe45[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
