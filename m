Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D20B5EDA36
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiI1Kgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiI1Kg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:36:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE7566130;
        Wed, 28 Sep 2022 03:36:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so11344861wrb.13;
        Wed, 28 Sep 2022 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=+IUuTOpUG9E3kEMkZMvCbwk8jBPBV1cYbzQF2o9+mRE=;
        b=er1zGT1Py/2ZjBWJXMv2qtP14BtOd1BunBPwDKuPdyTlaEX0oOh57EfSfCVSp5qLFt
         8cwXYMk6MkLCKauUfSOan4ARlPfdvFg2+a7N3biRj6HRs/tl+bjYSfMRRSwPkDIKqCl6
         60W1oWUvYPDSaVAY3r0Ijhsryo97AxS8e7ooNS03/4PplRYSFBBCKj7+nSVfQtmKTiKN
         JGIHLafOAEK47Fl+M0imCpCQW87JxVA/YdrivL9IJIGYGsORw+2DH0EpvsyvWeq8KJg/
         5hB3rAHuj/tYpGQHGITEpBbVeB9pvLzTcd/Ahc156W57zD8XnvsbRtpSf5PGj5vaS1la
         dH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=+IUuTOpUG9E3kEMkZMvCbwk8jBPBV1cYbzQF2o9+mRE=;
        b=I82cbHFfsaEEbgnMJLZL+Es6WuJHClcLrqkKRaQwho5Zi71jqAlcIM+o0c9E1tnFRa
         aKE3gO5OfEo6TFxG+eOlVkh4spgNbzejdYGVDHA5uksciTCQXDe037jytzFf+Vt35gDh
         VLQ2vA1RHAJD4P4JZ3X7R36/KXm1gZIqBxcC2sfRijTWsfHMLVgTXK6gwqtgg8lpRegm
         IZWi+3dH7WukMWqKuKiwQXjkNgsfelSsSUD0/KeLiVe4YcHtREBOnvbYtFOnFeQRwtpG
         KfzZEJcSKpgKJoD9Up1mb34r0H6tN810XX/MmUy1sla7uB1oOyuOupc6zKOP7L7k0rZt
         WkHQ==
X-Gm-Message-State: ACrzQf27U+jAsCrl4dgCenac8RVdQwJncS99RZynqGNjP3Cr/FUORO+y
        4oAuMVkw3c4ZOH4UdVCISEc=
X-Google-Smtp-Source: AMsMyM6iofkjO4eX8Dzsn0n5ooEJ3V5O8nlCEQ/m8d5q9ZAFcEqp62JvDgoMLCEnN/eDhYgbBL6BKg==
X-Received: by 2002:a5d:6447:0:b0:22c:c621:ef73 with SMTP id d7-20020a5d6447000000b0022cc621ef73mr2639073wrw.636.1664361384286;
        Wed, 28 Sep 2022 03:36:24 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm1439466wmc.14.2022.09.28.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:36:23 -0700 (PDT)
Message-ID: <0e2334ebc4ba0ba137e83c60a090fde536be7f26.camel@gmail.com>
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
From:   Bean Huo <huobean@gmail.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Date:   Wed, 28 Sep 2022 12:36:22 +0200
In-Reply-To: <BY5PR04MB6327ED5C6D91CBD3A024F709ED549@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
         <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
         <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
         <BY5PR04MB6327ED5C6D91CBD3A024F709ED549@BY5PR04MB6327.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-28 at 08:33 +0000, Arthur Simchaev wrote:
> Hi Bean
>=20
> In case you don't have any comments I will appreciate if you will add
> "reviewed by" to the patch.
>=20
> Regards
> Arthur


Hi Arthur,

I'm thinking we should remove the desc size check in ufshcd.c entirely.
Just read any descriptor with a maximum size of QUERY_DESC_MAX_SIZE .
For user space queries, ufs_bsg reads data of the maximum length and
returns the requested length data. Thus can improve code readability
and save CPU cycles, also can fix your concern.

I don't know how about others' opinion?

Kind regards,
Bean



