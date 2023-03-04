Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F396AA69A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCDAo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDAoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:44:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7D19693
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:44:24 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id u9so17062715edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677890663;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IY2aEfV/uKES0OqcNR+qoL3AjeH0NHBNRvUcitEga7Y=;
        b=QbDePkl+pelxiBzFY3VeotWknAclTdK/Ub0LfE+eE6Wf3pPCVPEM3vtf6oqsbndCot
         q3LQvyQ57rlomU/BRsqAkNTBI6pjCgNmzkPCRxnPSF0Vh2jHlc4tdROipYKjTSkqTqcz
         U68ooykOhv+aUxrgNBPo1WjW5k2/y6E4l28n5wppEHOQ3ok20BJZ0os1EFdLahsOTWb4
         i1raAlmvhRa4/dULKiG5KJ0wBW/xmP2xrWNr8CTxm0/fLIUjwD7VwF7OANqIHuikxv57
         4m+t5BVe4b2Yj9/kP8MDCzhIvkVXFJvxcHAph6B4qFxdPfrDljlbvKbMqlL1tGXS2EOd
         5GHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677890663;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IY2aEfV/uKES0OqcNR+qoL3AjeH0NHBNRvUcitEga7Y=;
        b=cy0PHM1ooEN3HJEc72CT16LKHDpj6yAO+LIVLw+flF4T+7w3coGvcnnz+1DrXF0NES
         ed22lu9Sf/EQHsXwqgMl3NFUurMOA03BY9KWfPLP+OEV2Y23asV/yG4/Y3xPWcWKCdR1
         yg003z1ctPP1NHG3eQUpaMQ8IOqcOM35Qaj43FbCOuaC5BOxxix1Ag1V4kZLjIx9FHHH
         oQhEd6Pn/HskKK4NXsLI+dqxud8bdS2LSlPXVdcnboibp5kl5lZz8dO4i8f0UlyCUrmz
         nC+Cc/tImc2R8wAvSPHxpvdB4W68b0kKlXp/1nI1kQCGyUb8uXl12z2XhR2WQuL7aeH+
         t2ag==
X-Gm-Message-State: AO0yUKVTpu2lYvPsq8aQNm6U9CmbFxX6wHMVzh0gEdYz4xUVaNcI8Mpp
        U259ZXSexqBvVTMvutSkE81gV1qRVmNWlLNhNdo=
X-Google-Smtp-Source: AK7set+xxoUALcHWyeVrTVPWsULBtRlR1W8bEAO1tnNl2QO4r21U7t7jbWsHUiRE+llo9fCszoxKXZd49jQvNU8qwSQ=
X-Received: by 2002:a50:c345:0:b0:4be:f5a0:a810 with SMTP id
 q5-20020a50c345000000b004bef5a0a810mr2224814edb.0.1677890663069; Fri, 03 Mar
 2023 16:44:23 -0800 (PST)
MIME-Version: 1.0
Sender: amzaalassani66@gmail.com
Received: by 2002:a17:907:3d86:0:0:0:0 with HTTP; Fri, 3 Mar 2023 16:44:22
 -0800 (PST)
From:   Kayla Manthey <sergeantkayllamanthey@gmail.com>
Date:   Sat, 4 Mar 2023 00:44:22 +0000
X-Google-Sender-Auth: EsIebx4w0RPTt5QFEJiVUbsFiJM
Message-ID: <CAK58db+rkHVKyM76Kc-stjOLzw-VMGCFqKg03ht3ha2Qv4q5aQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello my dear, please did you receive my previous email?, Thank you.
