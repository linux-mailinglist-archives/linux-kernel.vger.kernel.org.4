Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF7638F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKYSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKYSQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:16:57 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F254B11;
        Fri, 25 Nov 2022 10:16:53 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z26so4815854pff.1;
        Fri, 25 Nov 2022 10:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U61PbKW05jYz9l60M6WT1lvaamndgipieyYOdFsydYY=;
        b=XIvESbp9tmgh1I3jE1Gn0K3Cf/iTfbhRmdysRGKWGWseHftrN36WvBEs5LtD03AiyT
         tmQGKLv4u7jEUzxNnLXp4uOxR/5Y5UcK+7tjncYtbB5UUrbFNhSLdn36uqGiqdhLYhCC
         1q92EUpCrkxyjgTNbdh1dksrc5CPhatrv55Ydcfnz/S83blJpiSnvq+CyrmpQS8srls1
         fNtrCr8Z+pBGTMXps8qn621aeoPqGaUOJmSqIfI/0Tyl8KWdxFuyl8PyYmnhp0k8yv4F
         jaSE9lVfJNOZ4+psOAfq33BtRY+xsLKVupwB/3VTbxE5o4/D+FOZ1SkQ3DOglkgIG6pQ
         Ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U61PbKW05jYz9l60M6WT1lvaamndgipieyYOdFsydYY=;
        b=h6CqH6pAQTTQYN/Ga6CXsppWNJpCvQOSsj4xj/nM2+ZyIzoZmxVR+QNQgwcdjySutu
         /Trbgryd31pOf9JNf4qWvXnZTEVw22tQCU0O8SK+C9QGon4rrsRAhOFHcmsA7oYFNY5R
         0nuy30Ubu2hYnLE74eBSpnJbvOrF8Dh7tP/qyWsTDwAFP/KufMUjbCJYxwh01Ao/x3rG
         GEWy083/BV5J9X1jd4M7/n3TpU62XkP/AdZVCfaVI/6LUKCNeaPDywxXBvXu//VJsy73
         U6POK/M6FOOIWtb8tERf/f8srG5cXeR5GIzRSg02bc9aj06oXcZnmHFGw23n/ZlS0sAO
         fvvA==
X-Gm-Message-State: ANoB5pmZ+w4GZRyT2P7XZIO1GBebo42PpE16PF9OWu0zSzVBZ6MD7UH6
        7WLePSEXkVpkLlFNuJ//D2eBRkgKfMejGLC9PdE=
X-Google-Smtp-Source: AA0mqf5pcMU+OZhibbISCZKF92d8A0KoAl8CBmbCbsg2q8d/AcA48BfdqIY7hQ3yIbrUTtAiNLgc2Da/ElBhX4Ww5fc=
X-Received: by 2002:a05:6a00:2403:b0:572:698b:5f69 with SMTP id
 z3-20020a056a00240300b00572698b5f69mr24258628pfh.54.1669400212937; Fri, 25
 Nov 2022 10:16:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a21:2d0b:b0:a6:57b6:b6d4 with HTTP; Fri, 25 Nov 2022
 10:16:52 -0800 (PST)
In-Reply-To: <81722eba-3910-2117-8b07-bb030ab754dd@gmail.com>
References: <43ccb0fb-119b-1afe-758b-e413729dd704@gmail.com> <81722eba-3910-2117-8b07-bb030ab754dd@gmail.com>
From:   Affe null <affenull2345@gmail.com>
Date:   Fri, 25 Nov 2022 19:16:52 +0100
Message-ID: <CACYkpDr204QaCEmfFfuVH_=CWxH6mRixeRoyv6QXav9T7YP-sQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: mipi-dbi-spi: Add
 missing property
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the spam, unfortunately I can use neither git-send-email nor
Mutt with GMail, so I had to use Thunderbird for sending the patches.

Regards,
Otto Pfl=C3=BCger
