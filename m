Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C285A5B7CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 23:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIMVTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 17:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIMVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 17:19:42 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0DFB1DA;
        Tue, 13 Sep 2022 14:19:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bj14so22692300wrb.12;
        Tue, 13 Sep 2022 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=htdCWLmxbmsEWyxMJuMVfS3prO4ROm1WpIkasWuHBRU=;
        b=Lo5cDMKtQLPWLTFAP6DKdlu2js42chQRxQ35m7kpV76bsX9LTqNZXS5CNOLKIc0aOZ
         HxYJ2/Yq2rxoFQ954GGBY/vpODDg34nrl7njURz3V5qsrXG8glkjaV6g2gidQf9pcorm
         ViHvgsI9L2WI1KWoZDUI4aCD7cpqjfuaa40oR+tQ8HuVerlu2z9agrq6MqKiQ+WlZoFX
         m81ojNh71/yJ7u3uUozh3s9GnlzQkiq810WVDBd2d6JSybG6qqE/qrFXiouWNkMSSfS+
         nrTVgyOS9qzQ7ntnzze/wOd9Ju5SSPFImyama5x2Re4dQ24kTSS/SJVIYWRFYRURNoOq
         T0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=htdCWLmxbmsEWyxMJuMVfS3prO4ROm1WpIkasWuHBRU=;
        b=E4OSafIrB7qRAvXVyUg1eBYrsbqZDCxmgxyUsfpgXn2xmK2agVLFstfhTgv9wwne6h
         +TAlQXn9Xp8f1UMzvPqhVI7510vNbtTBLRM1T6IMaiBtHakrs3kP9bk7oDX3IDMs6pNi
         RpkGSgOT8wRSKIPjLZ8IdlaPhXY54UGOrG9BolnBq29VTFh4pKi5khsTOCvZCAVygDPS
         hZcpAMcVC+e8Vp+hpBUS+rIgc4hDMMXXJhRBwonwQ74aWMGfmuwIEngvWjIO8UuQEWNn
         /quHGNp+yaFwOuzoiQ9guv1VGDi/oDmLtTYqtWU7AvAji6r4MkuNY33T8wGBxojT08qC
         ANzQ==
X-Gm-Message-State: ACgBeo2z+G3gL95nBkIr6PH19GgAgiuCBo+1pZHYVgtoNIZsYYBttnAF
        j/V8pBhRc8afTnQInVzHDA0=
X-Google-Smtp-Source: AA6agR7Xgse1r70JoF0+ifs9Qly7SWA3Jhw3gz4nQmsxSHm0WcRYOfaPV8kZwEdHKcXanNtw9ynXSw==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id o2-20020a5d4742000000b0022a3a88d9e6mr14558100wrs.438.1663103979498;
        Tue, 13 Sep 2022 14:19:39 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c192-20020a1c35c9000000b003b33943ce5esm14559941wma.32.2022.09.13.14.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 14:19:38 -0700 (PDT)
Message-ID: <00db702daded3ba25efe4cd44c5a79ffb735434e.camel@gmail.com>
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 13 Sep 2022 23:19:37 +0200
In-Reply-To: <YyCz7HR+0xsyw21M@smile.fi.intel.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
         <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
         <YyCz7HR+0xsyw21M@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-13 at 19:46 +0300, Andy Shevchenko wrote:
> On Tue, Sep 13, 2022 at 01:52:13AM +0200, Angel Iglesias wrote:
> > Adds compatibility with the new generation of this sensor, the BMP380.
> >=20
> > Includes basic sensor initialization to do pressure and temp
> > measurements and allows tuning oversampling settings for each channel.
> >=20
> > The compensation algorithms are adapted from the device datasheet and
> > the repository https://github.com/BoschSensortec/BMP3-Sensor-API.
>=20
> ...
>=20
> > =C2=A0 *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP1=
80-DS000-121.pdf
> > =C2=A0 *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP2=
80-DS001-12.pdf
> > =C2=A0 *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME2=
80_DS001-11.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bmp388-ds001.pdf
> > =C2=A0 */
>=20
> Shouldn't it be based on your patch to fix the links?
>=20
I thought of adding the patch fixing the links as a prerequisite commit, bu=
t in
the end decided to keep the patchsets independent to avoid codependencies.

Kind regards,
Angel
