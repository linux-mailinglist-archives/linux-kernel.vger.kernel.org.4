Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B795265F706
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjAEWva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjAEWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:51:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4115881E;
        Thu,  5 Jan 2023 14:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672959071; bh=NSLZI1m/lNbAaMV1aBmMR3Yb/5WljKG4hJlawG7yHAs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=t/1LJAzrT4uxLBXmEpFDP8hKuiZZXCtJoQxQq7WrmURPI+fkubiuBRPNA+v1mhOnr
         MIda1ul+uqhSF8vBP+OIxivbLeBdUTWPTbwHuSszhn/IzIe8AtLQMhVnrlRDTqXZTG
         xXCq4d/KtqpyvlZyM+mDlRQC5a638gg6twcOGhxzl/BAZJdOb+oOhglv+iYsr6CnJw
         OXXrn8Ofh6rBi0s05lYrpE813yVOZIBpal9Oht+qAtGUycYsjYVgnoHVZkr6F3vdPo
         4wRt+jYqq72IgsptOcpxiN2dGE+J3PjPqdudu6ymIgN/+rStdVZHz+EHfI1Dokl7dg
         WNUiX189JP2sQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N9Mtg-1ohkU70vP2-015FQX; Thu, 05 Jan 2023 23:51:11 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] (ftsteutates) Various fixes
Date:   Thu,  5 Jan 2023 23:51:04 +0100
Message-Id: <20230105225107.58308-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VoLIA9TcJlAZp5yhf8BLVqoHlBZ+Y1cU9SwXDDzF0XLhpWnjk+K
 703sgwzPCS6CPHnQSZCbgzDbWFM31IgHLlTIsuz8McLzt18olz1m7zN36qUBMKHnGVCxR/y
 ZIBCYttrcHbyDyJ4RG9NNBiaYbtfeiedg+S3l5a6hPHPyW76/NWhx1NbRWg0nEgh8FeG/ri
 pxjfleCscSi4AHjQwziug==
UI-OutboundReport: notjunk:1;M01:P0:PIL1Pu2APlg=;b//L5DF6iJb0IyTbkFMOY7NYnPH
 yQE9xsMSFoL05dYwsU2DkehC40gtGYN9bNWLJnNs/N+o59/k/hwXTBH1ibVQRkkpHielLjOTM
 BGA6jzAH7VqATC9P5qKzDd1Xnad1+t8IYzduvJm/I77j0ylVReismbipjM+HVZHWurdKurDv3
 SkAo2Zmt3aOJxFuP2hvMR6d3tsHJlicaDLswwy3nQeIVPTfiRWrypgf0/JutMm0hx5mH4KPCN
 mMzx4Q8YZp0L3koILKqIdufhUuqR2UcXj/xaAjeRizanES+RpXtGfqbz2ilmH8CsNsVw/U5zc
 dgP5euBGapzjqU7PPfC7EB8kdHsx/mcmJ5P/yFCyHW5irp4SSKqc5W7DTjjFkx7uU4FlaEzkn
 tcAaN25l/OfkUOcnN9Z2UuIPpBN8TLedZKroZG6jQGakOXSZntNbzS5pKmgkBIFZJxKDTeB8C
 hbx4vGZwIn1e+Zdi7WnZ4pBjufHm1waBZnnkMFw1rvfjrPpAdWjZEJ8xWrW20G/U4NdPuD8P8
 tur077WQMLSxWMGHbPt8Ary/0xAPposSKBVo0RWhR5PnJBUPoY/j7lVIlLDnrv93kYwYJ8Ik5
 qb6EeAzy8LmX4XrrShzx7V8xi2l3sZsFxBjpz/Iiu1Lpiof36UeTAp9H4v47GMEh4iBpzMnNs
 zqpodCZKqNa0EC3bOGW0dqR+e1bUoy3vgsFy4ZMBQsrFXU2NEAmWxMRoNdIRaf183dlqlN6zy
 XtlhgC/AXljzXLUciu3Usk+BUFVp51Cep7y4ofHFiZGsZnTBb2XelTdSE8cmx5BwTPeY9n48i
 a4Kv7w0KAr3hXal1uZxxLucduJrwyCnxjBV4mALJrLCJui5JEPQfA/SRzwqgF80Q8/a6tsImk
 dVO5CP+/VOwFxEOgPuaFVh/nOZWDzYyXrYUSLOrVBih1JkKyXF+W2JN4aYSP1xm2iNywLHffm
 Ydh3Y9bOGgVVSRWFWp/BTX9rrKg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains the missing changes from the previous series.

The first patch converts the driver to use the modern *_with_info() API,
while the second patch replaces the nonstandard fanX_source attributes
with standard pwmX_auto_channels_temp attributes. Since the behaviour of
the pwmX_auto_channels_temp attributes is a bit special with the teutates =
BMC,
it is added to the drivers documentation. The last patch adds support
for fanX_fault attributes, using information already available inside
the driver but not exported to userspace.

Changes since v1:
- Omit patches regarding the scaling of measurements and watchdog
  registration
- Split the patch regarding the API conversion into three separate
  patches
- introduce FTS_FAN_SOURCE_INVALID so the pwmX_auto_channels_temp
  attributes display proper values for unconnected fans

Armin Wolf (3):
  hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
  hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
  hwmon: (ftsteutates) Add support for fanX_fault attributes

 Documentation/hwmon/ftsteutates.rst |   5 +
 drivers/hwmon/ftsteutates.c         | 550 +++++++++++-----------------
 2 files changed, 210 insertions(+), 345 deletions(-)

=2D-
2.30.2

