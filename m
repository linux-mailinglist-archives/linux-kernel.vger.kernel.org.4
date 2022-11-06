Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D061E136
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKFJNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiKFJNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:13:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648FFC6;
        Sun,  6 Nov 2022 01:13:14 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d26so23079298eje.10;
        Sun, 06 Nov 2022 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB5x5Lb8Br6d/Jeea8bVOt5eSs5IgdDtxZC3hRWWkBA=;
        b=U8zWoIusLivflIrhe/QqeEUiTBHp0weDQtpu7a3iD1sc9QTKpwALpgF1vtgRfCzikb
         37wK32SeseS2JESpp01aC/H0tP0qOFSyd2ZFLVWP+RvfWoyE1KbjxaH3rxX0jkxtrlgJ
         D6USi7yXUC6kWqFuNsQzUPJaqoT9qZlwHyH2mQA4rILUJwQh3tpZaZbOgdAsquswiD1L
         p2ZpctsvirMCFQ/3saaqaii0fPnzKCyGC/7aHR+enUeY8lG7bv/DW4W44BETId09iXoa
         RX3yDYau3yE4BILllMhrojO6TJGi2PlX34S51wpMGtyy5OCxFuyQPOtqjporW0oe+YLD
         5mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB5x5Lb8Br6d/Jeea8bVOt5eSs5IgdDtxZC3hRWWkBA=;
        b=xbdMp6R1mhqS7JgA7QdnUEdh8hZVYfJ+gPUHNvDXRPD+1L1dxgQnBG8qA37KVjheJb
         Ic+r+Rxtrqah1ZpHFuzSB8ju5mOAFp5PrsyqFJe0MooSIPc2AbzhcBxKTBexxgMk1R9n
         emmpr610qDinWpVvu0wtXQJdrjb8JX+DuZZV12S2mKIeeS4kZlxQQSBVquuFK6uj53Id
         Mu8BqkgIMfEoQ0v8+jJZmNsfDTrUKFlPKVl1YmcN65IaJnzVna1qd0GJOGTur6cTI1vG
         P26KOTBvFI+hV5pB/t/mE+QBOJuNUOR17HV1JvLxU3despJlwssZddIoBPBp2zacu7Ml
         ONJA==
X-Gm-Message-State: ACrzQf0d1pKnM0bwxxLCI60FlDHPm0ilxmZ/m0qBv2E2FTUFqAom13a+
        J/WoqSgJD1tRfeQjmHVa8Eg5wKlmtuAUfA==
X-Google-Smtp-Source: AMsMyM7WcxErEBkvYvl5QcgwyJodv5qAgL63AB5uiIt8PX9pxynGvsrLzYqtMYJ/J3DxD2waFR33CQ==
X-Received: by 2002:a17:907:a4e:b0:77d:94d:8148 with SMTP id be14-20020a1709070a4e00b0077d094d8148mr40810136ejc.607.1667725992932;
        Sun, 06 Nov 2022 01:13:12 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id r23-20020aa7d597000000b004638ba0ea96sm2301896edq.97.2022.11.06.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 01:13:12 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 6/6] media: sun6i-csi: Add support for hooking to the isp devices
Date:   Sun, 06 Nov 2022 10:13:11 +0100
Message-ID: <2085642.OBFZWjSADL@jernej-laptop>
In-Reply-To: <20221103163717.246217-7-paul.kocialkowski@bootlin.com>
References: <20221103163717.246217-1-paul.kocialkowski@bootlin.com> <20221103163717.246217-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Dne =C4=8Detrtek, 03. november 2022 ob 17:37:17 CET je Paul Kocialkowski=20
napisal(a):
> In order to use the isp and csi together, both devices need to be
> parented to the same v4l2 and media devices. We use the isp as
> top-level device and let the csi code hook to its v4l2 and media
> devices when async subdev registration takes place.
>=20
> As a result v4l2/media device setup is only called when the ISP
> is missing and the capture device is registered after the devices
> are hooked. The bridge subdev and its notifier are registered
> without any device when the ISP is available. Top-level pointers
> for the devices are introduced to either redirect to the hooked ones
> (isp available) or the registered ones (isp missing).
>=20
> Also keep track of whether the capture node was setup or not to
> avoid cleaning up resources when it wasn't.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


