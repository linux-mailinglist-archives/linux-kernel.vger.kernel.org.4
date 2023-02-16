Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3164A6993A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBPLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBPLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:52:08 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D54DBE0;
        Thu, 16 Feb 2023 03:52:08 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id ow4so679099qkn.1;
        Thu, 16 Feb 2023 03:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCvmhgcYonUnPdG+esIO60ks+rKiZjYiiwI3DMsK52s=;
        b=T5lW0Oe5LWWY1x1RHVWHCTiZOB2nu1NRfMwV888ejAzL1j3iK9mSo7R40ZaaeXLyFX
         fb4ljprJm0bUrEmLckY4FasTG4jR91p0PRmifpNorxWLgt2WARw0vTu/oqHe//ilGBPQ
         G2JMj62Jm9gc7ad9dX7Q1DWIgFprXQ++VqGXJ5ecBo+5zTlwGS04vrFCyBR7mjp5067A
         XC7wzpuu42XbOlH5jaR03xjSLk0E7NRBI4JNRcXUkCscPvNJtjnbWVQjPjZRJpGxr4SM
         spnXwX5dl06aRZ/IQY8z9HTI5Fmyqh9IAzAjiDMIQg9SiNLRH1pz59ms4y3yh2Nqcj33
         35NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCvmhgcYonUnPdG+esIO60ks+rKiZjYiiwI3DMsK52s=;
        b=i/72iyEVf2GaGsmGHS/8+zL/XPb1ZAiHrSYPZ2yCF6Jk8UcQL+seHKhr1qJANWXe88
         L73DxYTBTN+DnC34WizCae1QUz7CcHgd0hYIAI84Dmm7ZkQQx92WayELdcdqu2oJUdwJ
         NW95jHmgBr0gd9A/hwTyaRAkDPuczXiMSHpmtLzTmeijhwLfjEfT3MeNu3zTXLY452rI
         QhAyCN7ko1zYtwcXV0LATMgXtBam22mJer5/A0yshofMBMi3NJOgGZozKtFG9vb5oCr/
         z5Atd0IJn4IshSE7volk8ZpR/cw96Y+LdagUeFiBurimv/Ux+X2MMceol+HD1rn2De7K
         DmIA==
X-Gm-Message-State: AO0yUKUsrOMYkMsSuWtJwilvvryQIeiybQ6n4LqJv6nkLBDseXoNKlKA
        0crGeTqoFcdKDt2ojc+7jFB/D7X6iAPHPNEU7Jw=
X-Google-Smtp-Source: AK7set+aXsvMMJp4Gx5Mm8+jG4Q8FsHa360GObRFOf3i4rr1gqxc/eCqrLEkwWhDf/L7qG9H2wYJkApdPyO8MZagj2o=
X-Received: by 2002:a37:a89:0:b0:725:ff53:b58e with SMTP id
 131-20020a370a89000000b00725ff53b58emr335302qkk.331.1676548327067; Thu, 16
 Feb 2023 03:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20230216041224.4731-1-orlandoch.dev@gmail.com>
 <20230216041224.4731-3-orlandoch.dev@gmail.com> <20230216054105.nmtft5ma4hiuqwib@t-8ch.de>
In-Reply-To: <20230216054105.nmtft5ma4hiuqwib@t-8ch.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 16 Feb 2023 13:51:31 +0200
Message-ID: <CAHp75Vd+hLS7DLbaA3zZ9V_HyT-ZMkMBJbxq7aq5WiPU0fV7Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: apple-magic-backlight: Add driver for keyboard
 backlight on internal Magic Keyboards
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Kerem Karabay <kekrby@gmail.com>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 7:41 AM Thomas Wei=C3=9Fschuh <thomas@t-8ch.de> wro=
te:
> On Thu, Feb 16, 2023 at 03:12:28PM +1100, Orlando Chamberlain wrote:

...

> Note: Only your cover letter has the "v2" prefix.
> Normally git format-patch should apply this properly to all patches when
> using --reroll-count.

There is an option -v<X>, where <X> is a version applied to all
patches in the lot.

--=20
With Best Regards,
Andy Shevchenko
