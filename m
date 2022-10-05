Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A15F50AD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJEIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJEIOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:14:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5ADB2F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664957675; x=1696493675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SdMh/MPCyraG17YaNrDDIy0LM93Tu13ppP2IVnYXgSU=;
  b=NId/lPVAJ7R5q2FHI3Iz7BB6i3AGcPHETDPIQl6+WTZ8b3P2K0qA8/+L
   sSRLJqznfE46oPNrAlmR8l7k80kYYPwQTPLWSIbJD1fJXxpgVsFQSgmmC
   f5naXKFU6owz4CTrWK7hvBmXV8ALPiyRx/6OoHI8VqlDc/gMjH7/wx7ui
   CFD/3SB1l1z19w6x1stAkEVwFD2EhCu6/Gg5FBLjDnsmY1W+jvRSs2EdQ
   LLHx0vB3x6Hw7qaK9xJzP7q8QLEaefGhR349dc8UD9kOAAXtneGsMFttq
   nQhVOvRB7QqM4SWcjyQaSYmyZo8WUOJWmZSMkn6q32AIZkHkos8MdGpdr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="367225620"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="367225620"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 01:14:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728570977"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728570977"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 05 Oct 2022 01:14:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 01:14:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 5 Oct 2022 01:14:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 5 Oct 2022 01:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iORsYD+RqtPF3TppoFjul5WpgAVDiVrx1+Fl8My2SYQki44NB6choP7FRbFFMPKH98GxZuS31tDosAD19g9K78rlk72lE+nu5EN4uO7FaaMUxu2OzXOsELsmlVVYapNozn9kxV/mJCqjZo6jf0B9n6gH11EYYXojhudgWnvMDC5T297ZJnTbhEg/HeJ+IPnhYmLmPSEo6IHcjCaHaV5UUJDbEdrAr6ieXj8sEaRgrC1GRvUzbPpoXVmiPetkqHunvVKfCfZ2aC3tVe0YagJVRRfihv8Lv7UopRV8ANgSn1AzNwWAPHFNb4Hq95ivKL5JzFX9YfiHXw1eDM5Gqckjqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90bN+bVxgFnpzpHsGDsdLZJ/e25pbLJjHLwmxs2aCQw=;
 b=Fpg4c81Ab5JodA7clGcrfvYIgXLWnecGM59JTwxkkrDhTYxWxBmcuMj4MLLhJTkoT3ucAl9w7DLDZ+n1dWUYwqjTly8C9rr0vSy1FUEqcX/RjnbkRLzbWEwPuyDHj3/d54c0YUBJzFWq8RuNT6dscTdQxiharCGZI1HdS26MtSQon6izp3ft2cnCsVbA5vCDxeLY6iRqCi+KOD0YXtpjmrGwswUve5mnLSBtqEuAnjA3PNh00TpwPZ9ORdx5Lkwz9zopg6DsE956u9m8EHdyVwM/0nGYPc9KDB1mVu+vTbpQZyr3vXomhMLIr7xmTc3SxvOTQfhhIGVFF2eNkxcQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6257.namprd11.prod.outlook.com (2603:10b6:930:26::22)
 by CY8PR11MB6891.namprd11.prod.outlook.com (2603:10b6:930:5c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Wed, 5 Oct
 2022 08:14:20 +0000
Received: from CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88]) by CY5PR11MB6257.namprd11.prod.outlook.com
 ([fe80::a351:42c7:fffd:fe88%6]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 08:14:20 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mohan Kumar <mkumard@nvidia.com>,
        =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/hdmi: run eld notify in delay work
Thread-Topic: [PATCH] ALSA: hda/hdmi: run eld notify in delay work
Thread-Index: AQHY0nlqZat1Y5WzgkyD+5XdJ6OJtq3zUR2AgADBjQCAAFxKAIAAD2kAgAAHvICACvj1IA==
Date:   Wed, 5 Oct 2022 08:14:19 +0000
Message-ID: <CY5PR11MB62571E282C37DDFBD4058D99975D9@CY5PR11MB6257.namprd11.prod.outlook.com>
References: <20220927135807.4097052-1-brent.lu@intel.com>
        <87ill8gb5c.wl-tiwai@suse.de>
        <CY5PR11MB6257CB33E1EDA90CE2B2F99D97549@CY5PR11MB6257.namprd11.prod.outlook.com>
        <875yh8ezs9.wl-tiwai@suse.de>   <871qrvgbsr.wl-tiwai@suse.de>
 <87y1u3evy6.wl-tiwai@suse.de>
In-Reply-To: <87y1u3evy6.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6257:EE_|CY8PR11MB6891:EE_
x-ms-office365-filtering-correlation-id: 09571cc9-5eb7-4e69-9324-08daa6a99a9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8x8XJjw3G2cRxLsExkGIeBges6WtQhx8rFU11jbWCQxcV3v+XXAgEeLw/wpKIVgK2onHy/zOSwJKW64cmd+Nu4OPLrUFYZ1PKxysugxJHMUt/Xl0WuwYDDYZXYru6ACaZ5/5k9xbuTz/BtKGPGhHnE5Duqy/s+1HRV9X1emaDA+SgOYfZKkWAfDVkS1u/NIRE1bobPrUU6jc9RqPfbPyKU/CV9OkdtH5mb3V538JSL01DEB33KX5+gAkKGyZJEPrqm2KlP+EMPP/GeX9ijsSgPJ1wX+YiNJbsYUBjXekgDpyv/4d8YKAQeAB34tRm3ul3hTicoUDwnmT+2/49HpOi2LHABTtU1064A9dsiQdLI118CnojiDqsFjl4K2+gI+zBxcsicCSB4HAcQBIQG558IGQxdvXz/pGZ1G38ViTfT5bjcime9m5GtwDe/W/zwZvaj4AUzY7jeoaSy5vuIJ8eij67jeEzwsRd8I02SPtZPnSGS7umoh55zyLX3mST8KZb2tP46sv8p4WWqEN5ZhDkPUMZyezejWMvLWYe6Si4fHS8JLn+nxHbsGv5oavbwSBVV6TO7+wurhKBknDql5XXAWuFYlhGMFbMQTycJpOPbN3C9ViChNp/DGSZ/haNQt851ioSzUmP5z058Sqiv2Roc5m3xkLRvbwUT15eg9PiBgoLIs6t7rrH8SUuxXsg65Y+cdXoDBegFbEsnipALcdseHV8quFWGEOHnpuLR+RBlO/LVG5qzZzh1PVzamG/v6827KvFhDm2V1i1AM+83CtUThxJTBI1nmytX2oz/cw2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6257.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199015)(71200400001)(38070700005)(54906003)(6916009)(478600001)(52536014)(86362001)(41300700001)(8936002)(66556008)(5660300002)(316002)(76116006)(66476007)(33656002)(66446008)(64756008)(8676002)(4326008)(66946007)(9686003)(55016003)(186003)(122000001)(82960400001)(26005)(83380400001)(38100700002)(6506007)(7696005)(66899015)(2906002)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?a1WuBseNYrHGy42ix0ZJu7IYFHOKTx9g5YMIDTmeRJUdFCstHngBrG+mpx?=
 =?iso-8859-1?Q?zySWla/2QPVPpfmbUcycky44dgl0bxa3WX0ipz90BIU0NsQ85JN/1qZ5fy?=
 =?iso-8859-1?Q?3KmjYBIB3fU9cjwRq0CI2K6Oj0zqzvbdg6YeDaKLukf9Zt4MDFZCE8+5O4?=
 =?iso-8859-1?Q?N+euPDkLiqUBHBsQU8ZspJA57ONDk/zxbRYY4N0L9ZYnFa6q5Cf5GEOLZY?=
 =?iso-8859-1?Q?EBpzfLr9F0hD+pqzkzbms9sSLjLczXrfvUQm+qKvuHRX2+jtiuSHiB5BxT?=
 =?iso-8859-1?Q?y9tuXQM30eEbi2O2wqwBG5jH9HViQkmzkmhBUB1zDuL1/cPkWRGG+C0WvJ?=
 =?iso-8859-1?Q?pp8e9dROL4PkrM939lFYHFq6M5XyuQ7OEsqVBy5uCqLvWWopiaXnKIYcuN?=
 =?iso-8859-1?Q?QEb6lucFb3brkLmY6/OcbjMeQLeXC8h6nQLUWqDcvM0U3xdFV5bWsC70j5?=
 =?iso-8859-1?Q?8JkmhX2+i6iP2EeAWN3YwdnY2CB/c4KpYKLGynqxH38RAR3mqRVR9YZNIR?=
 =?iso-8859-1?Q?FbVKg9el7QENfuPTtsh2danVwKHwLiN0pL7PJyvdNsb/Ul9FmSFzbmed+Q?=
 =?iso-8859-1?Q?ZFqlBTwV/Cuv5lGXl0kqObUYES1FBCtuWykOjsawPy0fuKbJIW50JypW6F?=
 =?iso-8859-1?Q?IOfeHDkybo1VA4721bvNT0EarN9focI5y2ZJta+a7OK5QT63JVkpXPXHBR?=
 =?iso-8859-1?Q?CTzVhMujoAwy+Wk3CTK7BUKQ9slak3Hoig3i50N75+XunZv4pOidskAOpB?=
 =?iso-8859-1?Q?Bl/tN6Yzl5KRjN67MPzvH41lSifxPGtq8SztPRZx5M1+V4ZUgWPw8HOJVK?=
 =?iso-8859-1?Q?7/Pk2p3MHoZL0zBMgxk0E1ncsRUwo2ALgyv4PMl/1qzDxRltQM+bgc9w2T?=
 =?iso-8859-1?Q?pzCT2tmVPRtfJeyqH8QOu0QWjbJbPEeUn2hICXk0/3uCZDAKOldmtkHJDr?=
 =?iso-8859-1?Q?WtoxsS9HH0VaQXg8GUypTWlaPj1HJMCK1sMW4tVaOuBbUT3S5br+bkwurf?=
 =?iso-8859-1?Q?1li1/IYqBWHe4xNkF2IrSsxZxc6rPNAHxALJPiLO/7xZcfO7k/eVchRRzH?=
 =?iso-8859-1?Q?0kqA+X8E1WnAcSDMGctfRvvXz6IOs3TxW5i35vC5M3h9Qd4+gZCzt3m8Cj?=
 =?iso-8859-1?Q?RUzleZSjpN729QGKMqdsi+SwxmLWWJMakHSy8RkqI7KJcWgZZckT37VbRa?=
 =?iso-8859-1?Q?PGeZpt2aWQKFHs4x2/FTnHz303hGN9jrgwtL5/mU6JK0qjqhF+iBnvLsiA?=
 =?iso-8859-1?Q?XB8ix7gMkJ2YfC84t8UdL1PbMUUYIHCDimo/F4mgSwRrtdht6URbZu9C/H?=
 =?iso-8859-1?Q?i36cmgLMBOggwVhrXQWTtIJcik9D034pKbZFxJwrUs/2iHZaGVleX5rizm?=
 =?iso-8859-1?Q?jRjSgCsoxO+j9dEVTofrCdd70rZzW3GXiLS2Z7yAZUEr74zP8mw8zfXoe7?=
 =?iso-8859-1?Q?tcWUV/vhlFlllZ7skOfS3SMB5omkyLbVgl6/Z/KM1cjPzYEYMaq95YZkwj?=
 =?iso-8859-1?Q?dch9tUM3046kIbX1fk+aJzcKGb3PN9C5qtwGtET7zAfFv9EbfmwFZpxPX6?=
 =?iso-8859-1?Q?zNDN3paLX350Ip/yArwNioCr/J/ILH0g5ylOMQItGOWvyzjxQr8jXlA+iQ?=
 =?iso-8859-1?Q?ARbUSnITcOKIh7xrI/yxY8KwSTn+lZBRLH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6257.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09571cc9-5eb7-4e69-9324-08daa6a99a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 08:14:19.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuRZ3ozgmiXCZaot6E6HDfLp0nhi+zf3ItrokqSBrhsPbsO7t/8Tr9/qBzrnJMJBEwGIOUGVCZ3x3l8olOCxRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6891
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> ... and on the further consideration, I believe the best solution is to j=
ust get rid of
> the whole check.
>=20
> It was introduced by the commit eb399d3c99d8 along with the 8ae743e82f0b
> that checks the suspend state.  The latter is still meaningful (we should=
 skip the
> bogus notification at suspend).
> However, the former -- the code path we're dealing with -- doesn't help m=
uch in
> the recent code.  That fix was required because the driver probed the ELD=
 bits
> via HD-audio verb at the time of the fix commit; that is, the driver had =
to wake
> up the codec for updating the ELD.  OTOH, now ELD is read directly from t=
he
> graphics chip without the codec wakeup.  So the skip makes little sense.
Hi Takashi,

I've got the test result from ODM which is positive. During 60 test runs, t=
he elf notify
running in suspend happened 10 times and the audio is normal. The patch is =
looking
good.


Regards,
Brent

>=20
> The fix patch is below.
>=20
>=20
> Takashi
>=20
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda/hdmi: Don't skip notification handling during =
PM
> operation
>=20
> The HDMI driver skips the notification handling from the graphics driver =
when
> the codec driver is being in the PM operation.  This behavior was introdu=
ced by
> the commit eb399d3c99d8 ("ALSA: hda - Skip ELD notification during PM
> process").  This skip may cause a problem, as we may miss the ELD update =
when
> the connection/disconnection happens right at the runtime-PM operation of=
 the
> audio codec.
>=20
> Although this workaround was valid at that time, it's no longer true; the=
 fix was
> required just because the ELD update procedure needed to wake up the audi=
o
> codec, which had lead to a runtime-resume during a runtime-suspend.
> Meanwhile, the ELD update procedure doesn't need a codec wake up any long=
er
> since the commit 788d441a164c ("ALSA: hda - Use component ops for i915
> HDMI/DP audio jack handling"); i.e. there is no much reason for skipping =
the
> notification.
>=20
> Let's drop those checks for addressing the missing notification.
>=20
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/patch_hdmi.c | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c inde=
x
> c172640c8a41..21edf7a619f0 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -2666,9 +2666,6 @@ static void generic_acomp_pin_eld_notify(void
> *audio_ptr, int port, int dev_id)
>  	 */
>  	if (codec->core.dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND)
>  		return;
> -	/* ditto during suspend/resume process itself */
> -	if (snd_hdac_is_in_pm(&codec->core))
> -		return;
>=20
>  	check_presence_and_report(codec, pin_nid, dev_id);  } @@ -2852,9
> +2849,6 @@ static void intel_pin_eld_notify(void *audio_ptr, int port, in=
t pipe)
>  	 */
>  	if (codec->core.dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND)
>  		return;
> -	/* ditto during suspend/resume process itself */
> -	if (snd_hdac_is_in_pm(&codec->core))
> -		return;
>=20
>  	snd_hdac_i915_set_bclk(&codec->bus->core);
>  	check_presence_and_report(codec, pin_nid, dev_id);
> --
> 2.35.3

