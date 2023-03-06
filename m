Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4E6ABF4E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCFMQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjCFMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:16:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA32A99B;
        Mon,  6 Mar 2023 04:16:35 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l25so8593855wrb.3;
        Mon, 06 Mar 2023 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678104994;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rlBIhyxmZ71ToNHpy5Y5u3P6vJwhvrMUv8FnCvij4k=;
        b=GBZXHFVTX/nW7TfztXUpgb9u4EZwalKnVSWhWRlUNL1HrGhladuhW4RqDJ+desSKBq
         B6dOEb2OUkPDDtnh2ml5puA3h1vN8FZ5KBbZZ639qFYS8dXim9O1GyZ149GYyBwoXiog
         ebtc8VTIWv9rylU1ME+WvJEF0pVB95Pjr8LaO14JWfyILr0OxS7nsCI8yH36NRkE6nc6
         e895DR7rVRNZbkm0kQNw1VJ4tkInR65KlCG8ino1dXeaY+IS9LSFnZPgKa7KlQf0JNcx
         f4moetX10h88dT26GN3gfHHftCrPYTK9VhlyQAVuh/qCk3ovsA1cvTLtBFtu5PTMU5vf
         zxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678104994;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rlBIhyxmZ71ToNHpy5Y5u3P6vJwhvrMUv8FnCvij4k=;
        b=12AxfyZA41l/VjjVbvKCBCamRIOBNJ9Mr+eyK03wr9zUNRKz3SyoI1l7ior/dyOr/R
         8Ul/jD7BLv90FK8H8Tc8syWyHnl/ZnprXrGsOVUHwj06A59Hxx6i0CPwM8QZyxKWl4iK
         aFN7i9pPG8uBcV0qEeKDMharoF9jzYlcGludlRFZucmwRYJzhFw2tqed4fB43dmyRNhl
         MPh2ccvnuyW6uaq9cOxVR4NmHrxKYWn4r76rPsTaHtM9nW5/sJKmFn/GRAXrBk09oX+l
         3MR53qLU7gqCXsH3eyZ0tbe2vIrrGKxCK1l83poPpM5jQg3ysJ/b8CqxL/js053VYP3K
         wFsQ==
X-Gm-Message-State: AO0yUKUSA/f7/Tiilzmndt9VpW+F20xCh6W+Pj+SfsZmBE+4vQTBPzuN
        2OV1qcyypYEXH0XNrmN6WeY=
X-Google-Smtp-Source: AK7set/dr5gwWAwOoOQIEaDI1DmLE8EnieEcXWk9g4KmUrTN8MWgILONe9KJ7EE/5eh28WmC3KC5dQ==
X-Received: by 2002:adf:dc89:0:b0:2c7:1d0d:7183 with SMTP id r9-20020adfdc89000000b002c71d0d7183mr6359306wrj.9.1678104994318;
        Mon, 06 Mar 2023 04:16:34 -0800 (PST)
Received: from smtpclient.apple ([167.99.200.149])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d67d0000000b002c758fe9689sm9628435wrw.52.2023.03.06.04.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2023 04:16:34 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: gxbb-kii-pro: device-tree
 updates
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <3db5ae6c-a3f1-b64a-b605-4eac32fb4086@linaro.org>
Date:   Mon, 6 Mar 2023 16:16:29 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9CCCF479-88B7-4C02-B0D7-B2B062B7E7B7@gmail.com>
References: <20230210170721.1285914-1-christianshewitt@gmail.com>
 <3db5ae6c-a3f1-b64a-b605-4eac32fb4086@linaro.org>
To:     neil.armstrong@linaro.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 6 Mar 2023, at 12:40 pm, Neil Armstrong <neil.armstrong@linaro.org> =
wrote:
>=20
> Hi !
>=20
> On 10/02/2023 18:07, Christian Hewitt wrote:
>> First we sort nodes in the current dts and remove some blank lines. =
Then we
>> add the remaining bits needed for Bluetooth to work. And finally we =
add the
>> AIU audio card to have HDMI and S/PDIF audio output.
>> Changes since v1:
>> - Add reviews from Neil
>> - Drop unneded 'okay' from audio patch
>> Christian Hewitt (3):
>>   arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
>>   arm64: dts: meson: gxbb-kii-pro: complete the bluetooth node
>>   arm64: dts: meson: gxbb-kii-pro: add initial audio support
>>  .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 83 =
++++++++++++++++---
>>  1 file changed, 72 insertions(+), 11 deletions(-)
>=20
> This doesn't apply anymore on v6.3-rc1, can you rebase ?
> Thanks!

v3 rebased on for-next sent.=20

Christian=
