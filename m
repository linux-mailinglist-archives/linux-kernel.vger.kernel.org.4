Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6735164B39D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbiLMKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiLMKwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:52:39 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1595240;
        Tue, 13 Dec 2022 02:52:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v7so7988560wmn.0;
        Tue, 13 Dec 2022 02:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMxFOXBv9LnNZ6YjEoVy07fikCsdOyEW4hQ8sBJcKFs=;
        b=hqwO3fukcegwkk4cL7rmEd4LF9aJCeSbjA+o7bnjNtqywfmK3n95y1+SMu8itscRAT
         FM5c+AS28Jt/lyqGL/wgAQuXoiBXbkioo+AzOgO7Phn2PwAEQ/wmBwV2PvmoEQBOrCYY
         Cw6jR/QL7o/QE6ilYGHVxyw/uMm4TLcN5/J6UJNu5mDWgMs1pQxRpKKHBQgPaiMEjcIq
         w1nG29Iq3spstgd/QuSl5VP1d1Fw1j5o0A77pp/riZDDD8GBTL8V8faBB/GQtWG5iDHX
         CJfNGAw13WBXEnvv1VOtq8JvyMS6cf7Xxt9uK0tN1YE0S4F+csyv2lGrMsHMdHtacJC0
         Fs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMxFOXBv9LnNZ6YjEoVy07fikCsdOyEW4hQ8sBJcKFs=;
        b=Se9frMfMSucVwryPtRTepE78GsjgFDnvDbosWCvjaXBBlLqH2ggTlJlAOpm8Is1PEa
         /JEhVOruVAthpv6f6quyvMltOorqn/KW0Luvc6XxlXrGoUMhIAUwQtKfUQWKxH3/KoES
         3H1xz2sHMFrGtv7MT2F6o2gKfz6c4ZHy55ckztoAu4Ot9KnMFjN9sLoFbXDnX/MJQEmh
         8Si15pHS3JjApPapKETv1aUznRF202htzij0K/da+YGeD/1EgVnmzR0xwKmF64AG6zTz
         qMjQVeVwqIaFFG4vSyefFNVWG0jJ0ouuebd2sDDLxOVt1fsIqEfph6L78ms5XW1jA733
         JxEw==
X-Gm-Message-State: ANoB5pmp3asgzWC9TIzfhbld1d/fSECJSB3Zj2HshUMT/GvqwajDVHL2
        bmlrfLaOaigUbbeAOTnKR0mies5QRzI=
X-Google-Smtp-Source: AA0mqf7mWwFpBamChx+Rh5h+Sg5K85tFvzMUwe6grn20jxGOq2H/TRGUaY4C9J3zMP4htc/XjQWx6w==
X-Received: by 2002:a05:600c:4fc6:b0:3d2:14ec:f6b1 with SMTP id o6-20020a05600c4fc600b003d214ecf6b1mr9968333wmq.14.1670928756034;
        Tue, 13 Dec 2022 02:52:36 -0800 (PST)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c1c9200b003d22528decesm8709380wms.43.2022.12.13.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:52:35 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:52:34 +0000
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: mainline build failure due to e1d7dc52c3e6 ("ARM: dts: suniv:
 f1c100s: add CIR DT node")
Message-ID: <Y5hZcmnZHsgpv3Pu@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build arm allmodconfig and
multi_v5_defconfig with the error:

Error: arch/arm/boot/dts/suniv-f1c100s.dtsi:250.30-31 syntax error
FATAL ERROR: Unable to parse input tree

git bisect pointed to e1d7dc52c3e6 ("ARM: dts: suniv: f1c100s: add CIR DT node")

I will be happy to test any patch or provide any extra log if needed.


-- 
Regards
Sudip
