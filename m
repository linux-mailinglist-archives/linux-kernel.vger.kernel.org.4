Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B66574FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 10:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiL1Jwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 04:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiL1Jw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 04:52:29 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FC4B74;
        Wed, 28 Dec 2022 01:52:28 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id d1so3438913ual.11;
        Wed, 28 Dec 2022 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMogUSlAiHPyH0AEAACLcteryhWYp3/F5J+NreDkLAU=;
        b=J6ajhNL7VsYQBb8HGZQx9rMSfGcYfcXxo5nNMIEyP3mH1FDUA/Fgmdu3R2neFGYpJD
         vLfWcEQD3TYRnUiVvXXD8DwcEsmt00sn6i48+NH3SgxzkMxq4iNUgzrJx5xTjzKCA+cI
         50gbjORdkq0P133OGt8b63T95d0PEF0nUNZaaHc3SQ3FquykcEv2YMatJmn+9f4yAPRS
         TOv+ubwGesuKZVPyWGdUpLL5o7kvncC8Q+u7HZomAs5GWnlikwGxpBDHsp2IRE7aa8qs
         rcnA3kbNkCi5YcpzcOMGBjRj3WSPgW/1CXYVMwiPQrMwVcWj+cdR9SQnEH2ri3TWjP1P
         6D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMogUSlAiHPyH0AEAACLcteryhWYp3/F5J+NreDkLAU=;
        b=ai6VtYxhDzabQr1G4ybOMm9tGprqDVwVU9DixpEkJ9DyG8rcdbxRauCpXkAnvxgDvy
         8LFSvF/Xr8FK5Pl3uNrEQM6smssduD/Q3+zZW9mxjZTnrF/xDcV6WZHe0ymPbCHBcl4o
         sr+wUkUBqJ5/jFL2LJt5BcmW2FtQ+zbV2R1hcs9Aj7sVpgE2iLt49fCJXQTEj5gM+AA3
         oJvENGo4tSy2hxMKrERUus+UOXajQ4qVPf8aqo92vmG4pn4/I5nxibbfJINT0okQYwO4
         kxkFiP51WW76XuAegayxz2TQOKIvNoUnFTMBsItL9bUSI0wa4e8kiAkdPvX5TQqaNA3e
         X0rA==
X-Gm-Message-State: AFqh2krWBdg/VBOQhAlDB78TNw841qlNlBqThH2DPVu7w3AI1fmWYOBA
        MVSeC2fpwfDaFMrvUfmowYsUtrME40ztutxl0Mw=
X-Google-Smtp-Source: AMrXdXuw1nAiJmoWckgoP6fZNi9PwxDfSZLGl3H3I1DhOHYVkJ6HlpQtnKZbsmmHlkL76yYY8J6p6pGbeV5euq5ou1k=
X-Received: by 2002:ab0:1e86:0:b0:42f:555b:e4e0 with SMTP id
 o6-20020ab01e86000000b0042f555be4e0mr2176738uak.19.1672221147298; Wed, 28 Dec
 2022 01:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20221227095123.2447948-1-milkfafa@gmail.com> <20221227095123.2447948-4-milkfafa@gmail.com>
 <1cc66b84-fcf3-2801-57ad-94430fa38055@linaro.org>
In-Reply-To: <1cc66b84-fcf3-2801-57ad-94430fa38055@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Wed, 28 Dec 2022 17:52:16 +0800
Message-ID: <CADnNmFqQWi4a2YeizmYZjtTXKiipGbZ-cgwqeaqn4dNOTDu9OA@mail.gmail.com>
Subject: Re: [PATCH v10 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kflin@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the remind.

> The comment about subject from v8 applies here as well. Once you receive
> a comment apply it everywhere, fix all the issues, not only one.

I'll drop redundant "bindings for" in commit subject. Sorry for my negligence.

Regards,
Marvin
