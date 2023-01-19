Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E31B67331F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 08:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjASH6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 02:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjASH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 02:58:09 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA8A2202C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:58:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so823881wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 23:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij8SMr+vXbA/AZuiMltivscr4/Z1+1DiXSChaaWBJLA=;
        b=jNvClj4Hgs3XtM8osi2wmiQMtbXX9Pmtcv550+503yOGAXBRa9d6VoF6cZTm2h6Gjv
         vqqmXwxeBDQDNJFNBGX319WcRnTcclvjKfxqDfdIS30rx6KVsgnwyMEWlTKXRyc0Sm1S
         mT6WXhFENhT0S469DnFce32rQRt/pYYaIYOUIfZhQsd/6CIV99iyCTx6nLFqzlNgInrS
         cCvHfjWbI+6EBPHsRh6f0fBLcwDK9wLvu5FAYXYqrEVrL2EqadlKhKiQGZ+7HNMzwxLc
         oPDSOBQB00PBTJJ3qmuUvqX3Bv44IPfj9wYpGqyMB8IaWS9L0X8YL8/ELk/0dd9wpVwy
         2cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij8SMr+vXbA/AZuiMltivscr4/Z1+1DiXSChaaWBJLA=;
        b=qUrC7micNm3+iQ8wNuMfTUNwPy9M/4u9lqv9Qv6YUb4/V9QwxtiSfWqUUjqYjyGkpD
         tQU4ZB6qCUU2eRGPI4QnLwFXg0oVKmDnz+M2Qwmfg2SE4XrxlOUebzYmuro2q32CZq+l
         vevS51JUf3AIWNJknMMO+ncBjARzJlXDZmcaOuOLHl7J/yWgcmwaoF0ioeVakA9UJVQm
         E7Noe5olYdz1LZ9zg+dPf8BijJzkGH1WGfRHbpxfCZC6PZjL5DmamCc40iSWFPhsJ/Hg
         mdK30cu4O2g1D0K5xnhKuoK3N//wp7k7zcR2Wz/UU/GDhR5PhLmnPE72AHAf8SwqiM0Q
         NH6g==
X-Gm-Message-State: AFqh2kqXe2K9sf58+6K4JO6ZTilh83YXePlJ6sF6dYHlFRDMJlXI1Nd8
        zHq1uehntKjikEPX6zobAVgWrdE0B0CWd8yywiw=
X-Google-Smtp-Source: AMrXdXvJcNubzirilufX37J3RKkYIRh76X2L8Sjqd3Dsl7pC4Q5esy4zyFFYuUszjgUWfmEGPa2dtA==
X-Received: by 2002:a1c:4c0a:0:b0:3db:210:6a24 with SMTP id z10-20020a1c4c0a000000b003db02106a24mr9024938wmf.8.1674115084639;
        Wed, 18 Jan 2023 23:58:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b003d9b87296a9sm4115776wmo.25.2023.01.18.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 23:58:04 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
References: <20230114233455.2005047-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 0/2] ARM: dts: meson: Add more L2 (PL310) cache properties
Message-Id: <167411508395.294260.17502522944795124544.b4-ty@linaro.org>
Date:   Thu, 19 Jan 2023 08:58:03 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 15 Jan 2023 00:34:53 +0100, Martin Blumenstingl wrote:
> I had these patches in my testing tree for a while now. The vendor
> kernel uses the same configuration, so it probably makes sense to
> use them upstream as well.
> 
> 
> Martin Blumenstingl (2):
>   ARM: dts: meson8: Add more L2 (PL310) cache properties
>   ARM: dts: meson8b: Add more L2 (PL310) cache properties
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (for-next)

[1/2] ARM: dts: meson8: Add more L2 (PL310) cache properties
      https://git.kernel.org/amlogic/c/12cdc236cf83eb55560f52dd378f05d5798452ba
[2/2] ARM: dts: meson8b: Add more L2 (PL310) cache properties
      https://git.kernel.org/amlogic/c/46f73c1c037eed8e5fd61cc39c77b0988148b50b

These changes has been applied on the intermediate git tree [1].

The for-next branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
