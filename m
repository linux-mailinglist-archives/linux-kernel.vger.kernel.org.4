Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359D16B45BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjCJOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbjCJOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:36:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6F61188C7;
        Fri, 10 Mar 2023 06:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1678458941; i=p.jungkamp@gmx.net;
        bh=mFAKBwec07W+wMZVRlgIuZRX8jmMl9ZIB3CeRLO90eI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UH5Uf8lfBmK+dUPe26G/qqIMHOHA6gVNQXaotuK6yRg01QQT4NOibZONVNrNXsfLj
         D9eQ5KnUZUu0wzBzM5CWBMii0UP+HvKVHVOcMlw0zyWCpr9TDytcNjKW4KLv87jjE7
         +12lTQmvhXfrI7PQ01EoXP1xmwZQSDZSc+FIIlMBlI3mJv3EdwgblXNx25vKN0koYy
         +lTRvuXiCivmpPlcYXJsnbwX9UMi5GJPzYExH3zP2bqczE1qhDRChwxj75vQoemkc4
         SrgOdrxX1MsUTTuk5CrJzS/0+4e9Gd4zGz1yHk/0O29Duk/Aqa97fsP0wUOFYiL5BQ
         Nz93C1MxW7gYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from yoga9.fritz.box ([93.238.84.250]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRVb-1q2PSA2GPz-00XuER; Fri, 10
 Mar 2023 15:35:41 +0100
Message-ID: <424882ed2a79a641f88b5f2d1ed5a5d3d4fe98d9.camel@gmx.net>
Subject: Re: BUG: hid-sensor-ids code includes binary data in device name
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        todd.e.brandt@linux.intel.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Cc:     Jonathan.Cameron@huawei.com, jkosina@suse.cz,
        todd.e.brandt@intel.com
Date:   Fri, 10 Mar 2023 15:35:38 +0100
In-Reply-To: <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
References: <592bcdcbb3603cf5dfefd09abdd6916db4efc691.camel@linux.intel.com>
         <317ce138f63b9317ac7be1949a68db5117c19b92.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:FUveCr1Am3P8y4UZy/e3l87Y7WBAVrENwGPQpjNtgmnswCEz/+/
 5ykUALHVxxCBob9HxiORZViK16lHVVsa6c06BCLX9SlUBWsv1Ajoeu7y6ticUF4poTwKCfN
 b77Ij9b1tOEirIxrPE+YNb7gbBvSl00AE9w82ixfw+USV3SOcqv5TKJ8vGr5oY4+F+DCrTV
 DQ+NFR2MHAoe9mEs308wA==
UI-OutboundReport: notjunk:1;M01:P0:CpRuxpJGfuw=;R9k9rI7g0pCK8p4biNpGUWex0Xs
 zqMcUMMnapb0z/HZCaSulXaM6gP9hr64ibaN9gMTNiFsh5LKb1N16SPKQ0C/OocAwJwx6JFQS
 AulgOUrKfRm6Xchk7LKJgPILyE0V4jrfEcPSt3UqzgVmsjfF0Ci0bnBOylpavmRmcTVjy/fLR
 LASKXt0pKLSib2/uxTlc0Xt+TA53oWGQMpOQo7eHOlvIyhU8TYAERWk6wfDhqIA0pjAX8kbAX
 2KPt3OoE4g1m35XjiQDt3Iswc5B/6YAghtd6f4PzwLxrCdScvJp9Mjmnu7G4Hpsgn4ms6Yk3P
 dfO/FFYlUsafjRfpxXRmdB6Py4oDYbL0huJVELyH5y+BfkkamLr3CeMTYIIbTsOOZwF95lZFl
 MUG1DhTGgMPEH3NMfpCiYdxYoY36xqj7uUiIe12VgJBiT3AUVdlYLul0Pat+70tYpvbwuqUIO
 9U8hj9crx1u1M5nGFYgs0UFMMxlZe7RjzGzXO/mGgISRCZJoHHQMq3mpUK2LkCpdF00rJVRgs
 ID4LYSCdss6YkO/SW/59kghibMH++OOp7ccCDV8XEXgerNAmBwiMv0JyTTFpKbWM5Nh1a5SPL
 z3ljEC1s90iSmEyzU9eHtXfFLhcmLHJbn34l0xnMseiM8XO7JOLPSgMMrHYEteUhOU3kehHN4
 akbqqqDsl8oZbiGks/BYVKcj7NzJaGWe+g/+LbcX3NWw9ySBSggrZbVsLfv4X2LNVstGoszU5
 cgJwaP7Vn5uOe2nqJzVPmW65iliDlCGhwsvFIZmVBhH9B5d9jsmhEj7yNP/y2YqmwcgK9aTpO
 HddcvRLzmm45v3lMQbL47UskHLTZHNiOUV7fCAiT9FI9QWgew+3f77xZnKwEkw1jCPHZJO3/j
 LNF5b6YJsZBWQ7FsphBOF486yfNW9RiSv8NKkbWOzzapZb3z+sI26T1n+nODvmyv4hGuf4yBM
 DPb1rI2JQR5L4MhEd89JLqzMaOk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

on v3 of the patchset I had this comment on the 'real_usage'
initialization:

> > -	char real_usage[HID_SENSOR_USAGE_LENGTH] =3D { 0 };
> > +	char real_usage[HID_SENSOR_USAGE_LENGTH];
> >  	struct platform_device *custom_pdev;
> >  	const char *dev_name;
> >  	char *c;
> >=20
> > -	/* copy real usage id */
> > -	memcpy(real_usage, known_sensor_luid[index], 4);
> > +	memcpy(real_usage, match->luid, 4);
> > +	real_usage[4] =3D '\0';
>=20
> Why the change in approach for setting the NULL character?
> Doesn't seem relevant to main purpose of this patch.

Based on the comment, I changed that in the final v4 revision to:

> -       char real_usage[HID_SENSOR_USAGE_LENGTH] =3D { 0 };
> +       char real_usage[HID_SENSOR_USAGE_LENGTH];
>         struct platform_device *custom_pdev;
>         const char *dev_name;
>         char *c;
> =20
> -       /* copy real usage id */
> -       memcpy(real_usage, known_sensor_luid[index], 4);
> +       memcpy(real_usage, match->luid, 4);

I ommitted the line adding the null terminator to the string but kept
that I didn't initialize the 'real_usage' as { 0 } anymore. The string
now misses the null terminator which leads to the broken utf-8.

The simple fix is to reintroduce the 0 initialization in
hid_sensor_register_platform_device. E.g.

-	char real_usage[HID_SENSOR_USAGE_LENGTH];
+	char real_usage[HID_SENSOR_USAGE_LENGTH] =3D { 0 };

Where do I need to submit a patch for this? And on which tree should I
base the patch?

I'm sorry for the problems my patch caused.

Regards,
Philipp Jungkamp

On Fri, 2023-03-10 at 01:51 -0800, srinivas pandruvada wrote:
> +Even
>=20
> On Thu, 2023-03-09 at 15:33 -0800, Todd Brandt wrote:
> > Hi all, I've run into an issue in 6.3.0-rc1 that causes problems
> > with
> > ftrace and I've bisected it to this commit:
> >=20
> > commit 98c062e8245199fa9121141a0bf1035dc45ae90e (HEAD,
> > refs/bisect/bad)
> > Author: Philipp Jungkamp p.jungkamp@gmx.net
> > Date:=C2=A0=C2=A0 Fri Nov 25 00:38:38 2022 +0100
> >=20
> > =C2=A0=C2=A0=C2=A0 HID: hid-sensor-custom: Allow more custom iio sensor=
s
> >=20
> > =C2=A0=C2=A0=C2=A0 The known LUID table for established/known custom HI=
D sensors
> > was
> > =C2=A0=C2=A0=C2=A0 limited to sensors with "INTEL" as manufacturer. But=
 some
> > vendors
> > such
> > =C2=A0=C2=A0=C2=A0 as Lenovo also include fairly standard iio sensors (=
e.g.
> > ambient
> > light)
> > =C2=A0=C2=A0=C2=A0 in their custom sensors.
> >=20
> > =C2=A0=C2=A0=C2=A0 Expand the known custom sensors table by a tag used =
for the
> > platform
> > =C2=A0=C2=A0=C2=A0 device name and match sensors based on the LUID as w=
ell as
> > optionally
> > =C2=A0=C2=A0=C2=A0 on model and manufacturer properties.
> >=20
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Philipp Jungkamp p.jungkamp@gmx.net
> > =C2=A0=C2=A0=C2=A0 Reviewed-by: Jonathan Cameron Jonathan.Cameron@huawe=
i.com
> > =C2=A0=C2=A0=C2=A0 Acked-by: Srinivas Pandruvada
> > srinivas.pandruvada@linux.intel.com
> > =C2=A0=C2=A0=C2=A0 Signed-off-by: Jiri Kosina jkosina@suse.cz
> >=20
> > You're using raw data as part of the devname in the "real_usage"
> > string, but it includes chars other than ASCII, and those chars end
> > up being printed out in the ftrace log which is meant to be ASCII
> > only.
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-INT-REAL_USAGE_ID *=
/
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KERNEL=
, "HID-SENSOR-INT-%s",
> > real_usage);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* HID-SENSOR-TAG-REAL_USAGE_ID *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name =3D kasprintf(GFP_KERNEL=
, "HID-SENSOR-%s-%s",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 match->tag, real_usage);
> >=20
> > My sleepgraph tool started to crash because it read these lines
> > from
> > ftrace:
> >=20
> > device_pm_callback_start: platform HID-SENSOR-INT-020b?.39.auto,
> > parent: 001F:8087:0AC2.0003, [suspend]
> > device_pm_callback_end: platform HID-SENSOR-INT-020b?.39.auto,
> > err=3D0
> >=20
>=20
> Here tag is:
> .tag =3D "INT",
> .luid =3D "020B000000000000",
>=20
>=20
> The LUID is still a string. Probably too long for a dev_name.
>=20
> Even,
>=20
> Please check.
>=20
> Thanks.
> Srinivas
>=20
>=20
> > The "HID-SENSOR-INT-020b?.39.auto" string includes a binary char
> > that
> > kills
> > python3 code that loops through an ascii file as such:
> >=20
> > =C2=A0 File "/usr/bin/sleepgraph", line 5579, in executeSuspend
> > =C2=A0=C2=A0=C2=A0 for line in fp:
> > =C2=A0 File "/usr/lib/python3.10/codecs.py", line 322, in decode
> > =C2=A0=C2=A0=C2=A0 (result, consumed) =3D self._buffer_decode(data, sel=
f.errors,
> > final)
> > UnicodeDecodeError: 'utf-8' codec can't decode byte 0xff in
> > position
> > 1568: invalid start byte
> >=20
> > I've updated sleepgraph to handle random non-ascii chars, but other
> > tools
> > may suffer the same fate. Can you rewrite this to ensure that no
> > binary
> > chars make it into the devname?
> >=20
>=20

