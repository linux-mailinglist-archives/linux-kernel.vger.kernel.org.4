Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40FE74E00F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjGJVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjGJVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE9AE56
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:12:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3142ee41fd2so5026569f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1689023551; x=1691615551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WmkLuNsY2U0xSx8Li8ECdJ8OUSYHHkqPtgPIiQhAHpA=;
        b=OnJp3Z4rFo/waj+Si9HQXNIe2PUSTjzFZASUFywNIsKYwlXrG/KM5Smwyo9rX7dNzD
         XbGaD9+vcJCFPSiVGt5O2wtq+gJjetMhasfWO7iezGks4ogrtYwWGyUqoCb8HEPLqh+I
         b1Yr4IwGKiFe3im9dDygZoNl4WbnDi18xzXnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023551; x=1691615551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WmkLuNsY2U0xSx8Li8ECdJ8OUSYHHkqPtgPIiQhAHpA=;
        b=bnn5FlHXBlZcOdEnY8QVAGrcNjifEgzWt2EREVzYUA0ABFMpPjjbL44yFRGs0EwEnw
         meN1wZerPH4EBJoP2cDG8RajljeVEdUD+gEPwxtuJ+epbPz6cqM8X/NdC6J0vHalB539
         OZ+Hyuc3eyxFReGJ9YU9sbj/glrQfiabovHU8ou4yw2E9XSIevuPSiSZAwDtA0PxR7cy
         5xDRaDeiPJcOpDwwHN8DpXLDMl757lb4dd1P4ybcXtWnr9X1tJrmdGolPqEJM6XLd7rg
         oWLYsAeFdYw1REmeYoKwVV17C41g06VwVYbeorC4NsIJ+1QuPcgLxtG/v6ey5uG/7/NP
         RaIw==
X-Gm-Message-State: ABy/qLbNZq3coFzBSC8GqsuYZ8XM8IoFxesuryCCbzwLJcS0KMt8jM6Y
        /0UbMydBC+r+hibTk3L/WVlHoNaSLK3FvNooQIXfHz4gNv4IKSpQgrYuC6MxiNR2op1/C3eu31f
        zp/Cm2gNDvNjZiZKyy8cMbqoXSBmc4JQ=
X-Google-Smtp-Source: APBJJlFGeTHwiy78Kuv+ghdYmAotnzj1i/ghA6+0Ipkmp9IuEc25JdRsEJ8pNn8Ns2Hf15jtH4inPtykCB2nGisIpz4=
X-Received: by 2002:a5d:6086:0:b0:314:1494:fe28 with SMTP id
 w6-20020a5d6086000000b003141494fe28mr11605986wrt.53.1689023550967; Mon, 10
 Jul 2023 14:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <202307101756.leNPSOYr-lkp@intel.com>
In-Reply-To: <202307101756.leNPSOYr-lkp@intel.com>
From:   Justin Tee <justin.tee@broadcom.com>
Date:   Mon, 10 Jul 2023 14:12:18 -0700
Message-ID: <CAAmqgVN4es7AF5_jgNRQkm39c6DZdTNZRmMVmJbovrT1209yUA@mail.gmail.com>
Subject: Re: drivers/scsi/lpfc/lpfc_ct.c:3113:5: sparse: sparse: symbol
 'lpfc_fdmi_hba_action' was not declared. Should it be static?
To:     kernel test robot <lkp@intel.com>
Cc:     James Smart <jsmart2021@gmail.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000d1af0e0600287038"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d1af0e0600287038
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This has already been fixed on the latest master branch with the following:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D6e8a669e61af80d69d5ee16e0ddf3160178a63bc&h=3Dmaster
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D9cefd6e7e0a77b0fbca5c793f6fb6821b0962775&h=3Dmaster

Thanks,
Justin

On Mon, Jul 10, 2023 at 2:15=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> commit: 045c58c87560b2f9e44fe84e62ce68625a937fa7 scsi: lpfc: Rework FDMI =
attribute registration for unintential padding
> date:   10 months ago
> config: i386-randconfig-i061-20230710 (https://download.01.org/0day-ci/ar=
chive/20230710/202307101756.leNPSOYr-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230710/202307101756=
.leNPSOYr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307101756.leNPSOYr-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    drivers/scsi/lpfc/lpfc_ct.c:3581:15: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:3590:20: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3609:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3624:42: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3638:17: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:198:25: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:199:24: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:202:22: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse: sparse: incorrect type in =
assignment (different base types) @@     expected unsigned int [usertype] C=
mdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     expected unsigned int =
[usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:212:45: sparse:     got restricted __be16 =
[usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:510:32: sparse: sparse: cast to restricted=
 __be16
>    drivers/scsi/lpfc/lpfc_ct.c:511:32: sparse: sparse: cast to restricted=
 __be16
>    drivers/scsi/lpfc/lpfc_ct.c:531:32: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:532:33: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:534:30: sparse: sparse: cast to restricted=
 __le32
>    drivers/scsi/lpfc/lpfc_ct.c:880:33: sparse: sparse: cast to restricted=
 __be32
>    drivers/scsi/lpfc/lpfc_ct.c:882:40: sparse: sparse: restricted __be32 =
degrades to integer
>    drivers/scsi/lpfc/lpfc_ct.c:1032:21: sparse: sparse: restricted __be16=
 degrades to integer
>    drivers/scsi/lpfc/lpfc_ct.c:1047:28: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1251:21: sparse: sparse: restricted __be16=
 degrades to integer
>    drivers/scsi/lpfc/lpfc_ct.c:1266:28: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1369:15: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:1395:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1518:15: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:1534:30: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:1535:30: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:1623:19: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1685:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1706:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1727:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1748:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1781:21: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:1951:25: sparse: sparse: cast to restricte=
d __le32
>    drivers/scsi/lpfc/lpfc_ct.c:1952:24: sparse: sparse: cast to restricte=
d __le32
>    drivers/scsi/lpfc/lpfc_ct.c:1976:22: sparse: sparse: cast to restricte=
d __le32
>    drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:1987:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:1999:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2011:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortId @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     expected unsigned int=
 [usertype] PortId
>    drivers/scsi/lpfc/lpfc_ct.c:2013:38: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2018:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortId @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     expected unsigned int=
 [usertype] PortId
>    drivers/scsi/lpfc/lpfc_ct.c:2020:38: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2026:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2060:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortId @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     expected unsigned int=
 [usertype] PortId
>    drivers/scsi/lpfc/lpfc_ct.c:2062:38: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2070:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortId @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     expected unsigned int=
 [usertype] PortId
>    drivers/scsi/lpfc/lpfc_ct.c:2072:39: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2081:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2093:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
port_id @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     expected unsigned int=
 [usertype] port_id
>    drivers/scsi/lpfc/lpfc_ct.c:2095:41: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:2100:52: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortId @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     expected unsigned int=
 [usertype] PortId
>    drivers/scsi/lpfc/lpfc_ct.c:2102:38: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:2264:17: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:2280:16: sparse: sparse: cast to restricte=
d __be16
>    drivers/scsi/lpfc/lpfc_ct.c:2281:25: sparse: sparse: restricted __be16=
 degrades to integer
> >> drivers/scsi/lpfc/lpfc_ct.c:3113:5: sparse: sparse: symbol 'lpfc_fdmi_=
hba_action' was not declared. Should it be static?
> >> drivers/scsi/lpfc/lpfc_ct.c:3137:5: sparse: sparse: symbol 'lpfc_fdmi_=
port_action' was not declared. Should it be static?
>    drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:3241:44: sparse:     got restricted __be16=
 [usertype]
> >> drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
EntryCnt @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     expected unsigned int=
 [usertype] EntryCnt
>    drivers/scsi/lpfc/lpfc_ct.c:3258:42: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
EntryCnt @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     expected unsigned int=
 [usertype] EntryCnt
>    drivers/scsi/lpfc/lpfc_ct.c:3293:30: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
EntryCnt @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     expected unsigned int=
 [usertype] EntryCnt
>    drivers/scsi/lpfc/lpfc_ct.c:3353:34: sparse:     got restricted __be32=
 [usertype]
> >> drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
Size:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     expected unsigned int=
 [usertype] Size:16
>    drivers/scsi/lpfc/lpfc_ct.c:3397:42: sparse:     got restricted __be16=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3532:34: sparse: sparse: cast to restricte=
d __be32
>    drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
CmdRsp:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     expected unsigned int=
 [usertype] CmdRsp:16
>    drivers/scsi/lpfc/lpfc_ct.c:3736:44: sparse:     got restricted __be16=
 [usertype]
> >> drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortID @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     expected unsigned int=
 [usertype] PortID
>    drivers/scsi/lpfc/lpfc_ct.c:3744:34: sparse:     got restricted __be32=
 [usertype]
> >> drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
no_of_objects @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     expected unsigned int=
 [usertype] no_of_objects
>    drivers/scsi/lpfc/lpfc_ct.c:3747:36: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortID @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     expected unsigned int=
 [usertype] PortID
>    drivers/scsi/lpfc/lpfc_ct.c:3756:34: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortID @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     expected unsigned int=
 [usertype] PortID
>    drivers/scsi/lpfc/lpfc_ct.c:3763:34: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
no_of_objects @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     expected unsigned int=
 [usertype] no_of_objects
>    drivers/scsi/lpfc/lpfc_ct.c:3766:36: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
PortID @@     got restricted __be32 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     expected unsigned int=
 [usertype] PortID
>    drivers/scsi/lpfc/lpfc_ct.c:3778:34: sparse:     got restricted __be32=
 [usertype]
>    drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse: sparse: incorrect type in=
 assignment (different base types) @@     expected unsigned int [usertype] =
Size:16 @@     got restricted __be16 [usertype] @@
>    drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     expected unsigned int=
 [usertype] Size:16
>    drivers/scsi/lpfc/lpfc_ct.c:3789:42: sparse:     got restricted __be16=
 [usertype]
>
> vim +/lpfc_fdmi_hba_action +3113 drivers/scsi/lpfc/lpfc_ct.c
>
> 8aaa7bcf07a2ee James Smart         2020-10-20  3111
> 4258e98ee3862c James Smart         2015-12-16  3112  /* RHBA attribute ju=
mp table */
> 4258e98ee3862c James Smart         2015-12-16 @3113  int (*lpfc_fdmi_hba_=
action[])
> 045c58c87560b2 James Smart         2022-09-11  3114     (struct lpfc_vpor=
t *vport, void *attrbuf) =3D {
> 4258e98ee3862c James Smart         2015-12-16  3115     /* Action routine=
                 Mask bit     Attribute type */
> 4258e98ee3862c James Smart         2015-12-16  3116     lpfc_fdmi_hba_att=
r_wwnn,          /* bit0     RHBA_NODENAME           */
> 4258e98ee3862c James Smart         2015-12-16  3117     lpfc_fdmi_hba_att=
r_manufacturer,  /* bit1     RHBA_MANUFACTURER       */
> 4258e98ee3862c James Smart         2015-12-16  3118     lpfc_fdmi_hba_att=
r_sn,            /* bit2     RHBA_SERIAL_NUMBER      */
> 4258e98ee3862c James Smart         2015-12-16  3119     lpfc_fdmi_hba_att=
r_model,         /* bit3     RHBA_MODEL              */
> 4258e98ee3862c James Smart         2015-12-16  3120     lpfc_fdmi_hba_att=
r_description,   /* bit4     RHBA_MODEL_DESCRIPTION  */
> 4258e98ee3862c James Smart         2015-12-16  3121     lpfc_fdmi_hba_att=
r_hdw_ver,       /* bit5     RHBA_HARDWARE_VERSION   */
> 4258e98ee3862c James Smart         2015-12-16  3122     lpfc_fdmi_hba_att=
r_drvr_ver,      /* bit6     RHBA_DRIVER_VERSION     */
> 4258e98ee3862c James Smart         2015-12-16  3123     lpfc_fdmi_hba_att=
r_rom_ver,       /* bit7     RHBA_OPTION_ROM_VERSION */
> 4258e98ee3862c James Smart         2015-12-16  3124     lpfc_fdmi_hba_att=
r_fmw_ver,       /* bit8     RHBA_FIRMWARE_VERSION   */
> 4258e98ee3862c James Smart         2015-12-16  3125     lpfc_fdmi_hba_att=
r_os_ver,        /* bit9     RHBA_OS_NAME_VERSION    */
> 4258e98ee3862c James Smart         2015-12-16  3126     lpfc_fdmi_hba_att=
r_ct_len,        /* bit10    RHBA_MAX_CT_PAYLOAD_LEN */
> 4258e98ee3862c James Smart         2015-12-16  3127     lpfc_fdmi_hba_att=
r_symbolic_name, /* bit11    RHBA_SYM_NODENAME       */
> 4258e98ee3862c James Smart         2015-12-16  3128     lpfc_fdmi_hba_att=
r_vendor_info,   /* bit12    RHBA_VENDOR_INFO        */
> 4258e98ee3862c James Smart         2015-12-16  3129     lpfc_fdmi_hba_att=
r_num_ports,     /* bit13    RHBA_NUM_PORTS          */
> 4258e98ee3862c James Smart         2015-12-16  3130     lpfc_fdmi_hba_att=
r_fabric_wwnn,   /* bit14    RHBA_FABRIC_WWNN        */
> 4258e98ee3862c James Smart         2015-12-16  3131     lpfc_fdmi_hba_att=
r_bios_ver,      /* bit15    RHBA_BIOS_VERSION       */
> 4258e98ee3862c James Smart         2015-12-16  3132     lpfc_fdmi_hba_att=
r_bios_state,    /* bit16    RHBA_BIOS_STATE         */
> 4258e98ee3862c James Smart         2015-12-16  3133     lpfc_fdmi_hba_att=
r_vendor_id,     /* bit17    RHBA_VENDOR_ID          */
> 4258e98ee3862c James Smart         2015-12-16  3134  };
> 4258e98ee3862c James Smart         2015-12-16  3135
> 4258e98ee3862c James Smart         2015-12-16  3136  /* RPA / RPRT attrib=
ute jump table */
> 4258e98ee3862c James Smart         2015-12-16 @3137  int (*lpfc_fdmi_port=
_action[])
> 045c58c87560b2 James Smart         2022-09-11  3138     (struct lpfc_vpor=
t *vport, void *attrbuf) =3D {
> 4258e98ee3862c James Smart         2015-12-16  3139     /* Action routine=
                   Mask bit   Attribute type */
> 4258e98ee3862c James Smart         2015-12-16  3140     lpfc_fdmi_port_at=
tr_fc4type,        /* bit0   RPRT_SUPPORT_FC4_TYPES  */
> 4258e98ee3862c James Smart         2015-12-16  3141     lpfc_fdmi_port_at=
tr_support_speed,  /* bit1   RPRT_SUPPORTED_SPEED    */
> 4258e98ee3862c James Smart         2015-12-16  3142     lpfc_fdmi_port_at=
tr_speed,          /* bit2   RPRT_PORT_SPEED         */
> 4258e98ee3862c James Smart         2015-12-16  3143     lpfc_fdmi_port_at=
tr_max_frame,      /* bit3   RPRT_MAX_FRAME_SIZE     */
> 4258e98ee3862c James Smart         2015-12-16  3144     lpfc_fdmi_port_at=
tr_os_devname,     /* bit4   RPRT_OS_DEVICE_NAME     */
> 4258e98ee3862c James Smart         2015-12-16  3145     lpfc_fdmi_port_at=
tr_host_name,      /* bit5   RPRT_HOST_NAME          */
> 4258e98ee3862c James Smart         2015-12-16  3146     lpfc_fdmi_port_at=
tr_wwnn,           /* bit6   RPRT_NODENAME           */
> 4258e98ee3862c James Smart         2015-12-16  3147     lpfc_fdmi_port_at=
tr_wwpn,           /* bit7   RPRT_PORTNAME           */
> 4258e98ee3862c James Smart         2015-12-16  3148     lpfc_fdmi_port_at=
tr_symbolic_name,  /* bit8   RPRT_SYM_PORTNAME       */
> 4258e98ee3862c James Smart         2015-12-16  3149     lpfc_fdmi_port_at=
tr_port_type,      /* bit9   RPRT_PORT_TYPE          */
> 4258e98ee3862c James Smart         2015-12-16  3150     lpfc_fdmi_port_at=
tr_class,          /* bit10  RPRT_SUPPORTED_CLASS    */
> 4258e98ee3862c James Smart         2015-12-16  3151     lpfc_fdmi_port_at=
tr_fabric_wwpn,    /* bit11  RPRT_FABRICNAME         */
> 4258e98ee3862c James Smart         2015-12-16  3152     lpfc_fdmi_port_at=
tr_active_fc4type, /* bit12  RPRT_ACTIVE_FC4_TYPES   */
> 4258e98ee3862c James Smart         2015-12-16  3153     lpfc_fdmi_port_at=
tr_port_state,     /* bit13  RPRT_PORT_STATE         */
> 4258e98ee3862c James Smart         2015-12-16  3154     lpfc_fdmi_port_at=
tr_num_disc,       /* bit14  RPRT_DISC_PORT          */
> 4258e98ee3862c James Smart         2015-12-16  3155     lpfc_fdmi_port_at=
tr_nportid,        /* bit15  RPRT_PORT_ID            */
> 4258e98ee3862c James Smart         2015-12-16  3156     lpfc_fdmi_smart_a=
ttr_service,       /* bit16  RPRT_SMART_SERVICE      */
> 4258e98ee3862c James Smart         2015-12-16  3157     lpfc_fdmi_smart_a=
ttr_guid,          /* bit17  RPRT_SMART_GUID         */
> 4258e98ee3862c James Smart         2015-12-16  3158     lpfc_fdmi_smart_a=
ttr_version,       /* bit18  RPRT_SMART_VERSION      */
> 4258e98ee3862c James Smart         2015-12-16  3159     lpfc_fdmi_smart_a=
ttr_model,         /* bit19  RPRT_SMART_MODEL        */
> 4258e98ee3862c James Smart         2015-12-16  3160     lpfc_fdmi_smart_a=
ttr_port_info,     /* bit20  RPRT_SMART_PORT_INFO    */
> 4258e98ee3862c James Smart         2015-12-16  3161     lpfc_fdmi_smart_a=
ttr_qos,           /* bit21  RPRT_SMART_QOS          */
> 4258e98ee3862c James Smart         2015-12-16  3162     lpfc_fdmi_smart_a=
ttr_security,      /* bit22  RPRT_SMART_SECURITY     */
> 8aaa7bcf07a2ee James Smart         2020-10-20  3163     lpfc_fdmi_vendor_=
attr_mi,           /* bit23  RPRT_VENDOR_MI          */
> 4258e98ee3862c James Smart         2015-12-16  3164  };
> 4258e98ee3862c James Smart         2015-12-16  3165
> 4258e98ee3862c James Smart         2015-12-16  3166  /**
> 4258e98ee3862c James Smart         2015-12-16  3167   * lpfc_fdmi_cmd - B=
uild and send a FDMI cmd to the specified NPort
> 4258e98ee3862c James Smart         2015-12-16  3168   * @vport: pointer t=
o a host virtual N_Port data structure.
> 4258e98ee3862c James Smart         2015-12-16  3169   * @ndlp: ndlp to se=
nd FDMI cmd to (if NULL use FDMI_DID)
> 6265bc4a41cd86 Lee Jones           2020-07-21  3170   * @cmdcode: FDMI co=
mmand to send
> 6265bc4a41cd86 Lee Jones           2020-07-21  3171   * @new_mask: Mask o=
f HBA or PORT Attributes to send
> 4258e98ee3862c James Smart         2015-12-16  3172   *
> 4258e98ee3862c James Smart         2015-12-16  3173   * Builds and sends =
a FDMI command using the CT subsystem.
> 4258e98ee3862c James Smart         2015-12-16  3174   */
> 4258e98ee3862c James Smart         2015-12-16  3175  int
> 4258e98ee3862c James Smart         2015-12-16  3176  lpfc_fdmi_cmd(struct=
 lpfc_vport *vport, struct lpfc_nodelist *ndlp,
> 4258e98ee3862c James Smart         2015-12-16  3177           int cmdcode=
, uint32_t new_mask)
> 4258e98ee3862c James Smart         2015-12-16  3178  {
> 4258e98ee3862c James Smart         2015-12-16  3179     struct lpfc_hba *=
phba =3D vport->phba;
> d8cdd33a66dc8c James Smart         2022-09-11  3180     struct lpfc_dmabu=
f *rq, *rsp;
> 4258e98ee3862c James Smart         2015-12-16  3181     struct lpfc_sli_c=
t_request *CtReq;
> d8cdd33a66dc8c James Smart         2022-09-11  3182     struct ulp_bde64_=
le *bde;
> 4258e98ee3862c James Smart         2015-12-16  3183     uint32_t bit_pos;
> 045c58c87560b2 James Smart         2022-09-11  3184     uint32_t size, ad=
dsz;
> 4258e98ee3862c James Smart         2015-12-16  3185     uint32_t rsp_size=
;
> 4258e98ee3862c James Smart         2015-12-16  3186     uint32_t mask;
> 4258e98ee3862c James Smart         2015-12-16  3187     struct lpfc_fdmi_=
reg_hba *rh;
> 4258e98ee3862c James Smart         2015-12-16  3188     struct lpfc_fdmi_=
port_entry *pe;
> 2649809cd1b432 James Smart         2022-09-11  3189     struct lpfc_fdmi_=
reg_portattr *pab =3D NULL, *base =3D NULL;
> 4258e98ee3862c James Smart         2015-12-16  3190     struct lpfc_fdmi_=
attr_block *ab =3D NULL;
> 045c58c87560b2 James Smart         2022-09-11  3191     int  (*func)(stru=
ct lpfc_vport *vport, void *attrbuf);
> 045c58c87560b2 James Smart         2022-09-11  3192     void (*cmpl)(stru=
ct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
> 045c58c87560b2 James Smart         2022-09-11  3193                  stru=
ct lpfc_iocbq *rspiocb);
> 4258e98ee3862c James Smart         2015-12-16  3194
> 307e338097dc32 James Smart         2020-11-15  3195     if (!ndlp)
> 4258e98ee3862c James Smart         2015-12-16  3196             return 0;
> 4258e98ee3862c James Smart         2015-12-16  3197
> 4258e98ee3862c James Smart         2015-12-16  3198     cmpl =3D lpfc_cmp=
l_ct_disc_fdmi; /* called from discovery */
> 4258e98ee3862c James Smart         2015-12-16  3199
> 4258e98ee3862c James Smart         2015-12-16  3200     /* fill in BDEs f=
or command */
> 4258e98ee3862c James Smart         2015-12-16  3201     /* Allocate buffe=
r for command payload */
> d8cdd33a66dc8c James Smart         2022-09-11  3202     rq =3D kmalloc(si=
zeof(*rq), GFP_KERNEL);
> d8cdd33a66dc8c James Smart         2022-09-11  3203     if (!rq)
> 4258e98ee3862c James Smart         2015-12-16  3204             goto fdmi=
_cmd_exit;
> 4258e98ee3862c James Smart         2015-12-16  3205
> d8cdd33a66dc8c James Smart         2022-09-11  3206     rq->virt =3D lpfc=
_mbuf_alloc(phba, 0, &rq->phys);
> d8cdd33a66dc8c James Smart         2022-09-11  3207     if (!rq->virt)
> d8cdd33a66dc8c James Smart         2022-09-11  3208             goto fdmi=
_cmd_free_rq;
> 4258e98ee3862c James Smart         2015-12-16  3209
> 4258e98ee3862c James Smart         2015-12-16  3210     /* Allocate buffe=
r for Buffer ptr list */
> d8cdd33a66dc8c James Smart         2022-09-11  3211     rsp =3D kmalloc(s=
izeof(*rsp), GFP_KERNEL);
> d8cdd33a66dc8c James Smart         2022-09-11  3212     if (!rsp)
> d8cdd33a66dc8c James Smart         2022-09-11  3213             goto fdmi=
_cmd_free_rqvirt;
> 4258e98ee3862c James Smart         2015-12-16  3214
> d8cdd33a66dc8c James Smart         2022-09-11  3215     rsp->virt =3D lpf=
c_mbuf_alloc(phba, 0, &rsp->phys);
> d8cdd33a66dc8c James Smart         2022-09-11  3216     if (!rsp->virt)
> d8cdd33a66dc8c James Smart         2022-09-11  3217             goto fdmi=
_cmd_free_rsp;
> 4258e98ee3862c James Smart         2015-12-16  3218
> d8cdd33a66dc8c James Smart         2022-09-11  3219     INIT_LIST_HEAD(&r=
q->list);
> d8cdd33a66dc8c James Smart         2022-09-11  3220     INIT_LIST_HEAD(&r=
sp->list);
> 4258e98ee3862c James Smart         2015-12-16  3221
> 2649809cd1b432 James Smart         2022-09-11  3222     /* mbuf buffers a=
re 1K in length - aka LPFC_BPL_SIZE */
> 2649809cd1b432 James Smart         2022-09-11  3223     memset(rq->virt, =
0, LPFC_BPL_SIZE);
> 2649809cd1b432 James Smart         2022-09-11  3224     rsp_size =3D LPFC=
_BPL_SIZE;
> 2649809cd1b432 James Smart         2022-09-11  3225
> 4258e98ee3862c James Smart         2015-12-16  3226     /* FDMI request *=
/
> 4258e98ee3862c James Smart         2015-12-16  3227     lpfc_printf_vlog(=
vport, KERN_INFO, LOG_DISCOVERY,
> de3ec318fee323 James Smart         2022-05-05  3228                      =
"0218 FDMI Request x%x mask x%x Data: x%x x%x x%x\n",
> de3ec318fee323 James Smart         2022-05-05  3229                      =
cmdcode, new_mask, vport->fdmi_port_mask,
> de3ec318fee323 James Smart         2022-05-05  3230                      =
vport->fc_flag, vport->port_state);
> de3ec318fee323 James Smart         2022-05-05  3231
> d8cdd33a66dc8c James Smart         2022-09-11  3232     CtReq =3D (struct=
 lpfc_sli_ct_request *)rq->virt;
> 4258e98ee3862c James Smart         2015-12-16  3233
> 4258e98ee3862c James Smart         2015-12-16  3234     /* First populate=
 the CT_IU preamble */
> 4258e98ee3862c James Smart         2015-12-16  3235     CtReq->RevisionId=
.bits.Revision =3D SLI_CT_REVISION;
> 4258e98ee3862c James Smart         2015-12-16  3236     CtReq->RevisionId=
.bits.InId =3D 0;
> 4258e98ee3862c James Smart         2015-12-16  3237
> 4258e98ee3862c James Smart         2015-12-16  3238     CtReq->FsType =3D=
 SLI_CT_MANAGEMENT_SERVICE;
> 4258e98ee3862c James Smart         2015-12-16  3239     CtReq->FsSubType =
=3D SLI_CT_FDMI_Subtypes;
> 4258e98ee3862c James Smart         2015-12-16  3240
> 4258e98ee3862c James Smart         2015-12-16  3241     CtReq->CommandRes=
ponse.bits.CmdRsp =3D cpu_to_be16(cmdcode);
> 2649809cd1b432 James Smart         2022-09-11  3242
> 4258e98ee3862c James Smart         2015-12-16  3243     size =3D 0;
> 4258e98ee3862c James Smart         2015-12-16  3244
> 4258e98ee3862c James Smart         2015-12-16  3245     /* Next fill in t=
he specific FDMI cmd information */
> 4258e98ee3862c James Smart         2015-12-16  3246     switch (cmdcode) =
{
> 4258e98ee3862c James Smart         2015-12-16  3247     case SLI_MGMT_RHA=
T:
> 4258e98ee3862c James Smart         2015-12-16  3248     case SLI_MGMT_RHB=
A:
> 2649809cd1b432 James Smart         2022-09-11  3249             rh =3D (s=
truct lpfc_fdmi_reg_hba *)&CtReq->un;
> 4258e98ee3862c James Smart         2015-12-16  3250             /* HBA Id=
entifier */
> 4258e98ee3862c James Smart         2015-12-16  3251             memcpy(&r=
h->hi.PortName, &phba->pport->fc_sparam.portName,
> 4258e98ee3862c James Smart         2015-12-16  3252                    si=
zeof(struct lpfc_name));
> 2649809cd1b432 James Smart         2022-09-11  3253             size +=3D=
 sizeof(struct lpfc_fdmi_hba_ident);
> 4258e98ee3862c James Smart         2015-12-16  3254
> 4258e98ee3862c James Smart         2015-12-16  3255             if (cmdco=
de =3D=3D SLI_MGMT_RHBA) {
> 4258e98ee3862c James Smart         2015-12-16  3256                     /=
* Registered Port List */
> 4258e98ee3862c James Smart         2015-12-16  3257                     /=
* One entry (port) per adapter */
> 4258e98ee3862c James Smart         2015-12-16 @3258                     r=
h->rpl.EntryCnt =3D cpu_to_be32(1);
> 4cb9e1ddaa145b James Smart         2020-01-27  3259                     m=
emcpy(&rh->rpl.pe.PortName,
> 4cb9e1ddaa145b James Smart         2020-01-27  3260                      =
      &phba->pport->fc_sparam.portName,
> 4258e98ee3862c James Smart         2015-12-16  3261                      =
      sizeof(struct lpfc_name));
> 2649809cd1b432 James Smart         2022-09-11  3262                     s=
ize +=3D sizeof(struct lpfc_fdmi_reg_port_list);
> 4258e98ee3862c James Smart         2015-12-16  3263             }
> 2649809cd1b432 James Smart         2022-09-11  3264
> 4258e98ee3862c James Smart         2015-12-16  3265             ab =3D (s=
truct lpfc_fdmi_attr_block *)((uint8_t *)rh + size);
> 4258e98ee3862c James Smart         2015-12-16  3266             ab->Entry=
Cnt =3D 0;
> 2649809cd1b432 James Smart         2022-09-11  3267             size +=3D=
 FOURBYTES;      /* add length of EntryCnt field */
> 2649809cd1b432 James Smart         2022-09-11  3268
> 4258e98ee3862c James Smart         2015-12-16  3269             bit_pos =
=3D 0;
> 4258e98ee3862c James Smart         2015-12-16  3270             if (new_m=
ask)
> 4258e98ee3862c James Smart         2015-12-16  3271                     m=
ask =3D new_mask;
> 4258e98ee3862c James Smart         2015-12-16  3272             else
> 4258e98ee3862c James Smart         2015-12-16  3273                     m=
ask =3D vport->fdmi_hba_mask;
> 4258e98ee3862c James Smart         2015-12-16  3274
> 4258e98ee3862c James Smart         2015-12-16  3275             /* Mask w=
ill dictate what attributes to build in the request */
> 4258e98ee3862c James Smart         2015-12-16  3276             while (ma=
sk) {
> 4258e98ee3862c James Smart         2015-12-16  3277                     i=
f (mask & 0x1) {
> 4258e98ee3862c James Smart         2015-12-16  3278                      =
       func =3D lpfc_fdmi_hba_action[bit_pos];
> 045c58c87560b2 James Smart         2022-09-11  3279                      =
       addsz =3D func(vport, ((uint8_t *)rh + size));
> 045c58c87560b2 James Smart         2022-09-11  3280                      =
       if (addsz) {
> 4258e98ee3862c James Smart         2015-12-16  3281                      =
               ab->EntryCnt++;
> 045c58c87560b2 James Smart         2022-09-11  3282                      =
               size +=3D addsz;
> 045c58c87560b2 James Smart         2022-09-11  3283                      =
       }
> 2649809cd1b432 James Smart         2022-09-11  3284                      =
       /* check if another attribute fits */
> 045c58c87560b2 James Smart         2022-09-11  3285                      =
       if ((size + FDMI_MAX_ATTRLEN) >
> 4258e98ee3862c James Smart         2015-12-16  3286                      =
           (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
> 4258e98ee3862c James Smart         2015-12-16  3287                      =
               goto hba_out;
> 4258e98ee3862c James Smart         2015-12-16  3288                     }
> 4258e98ee3862c James Smart         2015-12-16  3289                     m=
ask =3D mask >> 1;
> 4258e98ee3862c James Smart         2015-12-16  3290                     b=
it_pos++;
> 4258e98ee3862c James Smart         2015-12-16  3291             }
> 4258e98ee3862c James Smart         2015-12-16  3292  hba_out:
> 4258e98ee3862c James Smart         2015-12-16  3293             ab->Entry=
Cnt =3D cpu_to_be32(ab->EntryCnt);
> 4258e98ee3862c James Smart         2015-12-16  3294             /* Total =
size */
> 2649809cd1b432 James Smart         2022-09-11  3295             size +=3D=
 GID_REQUEST_SZ - 4;
> 4258e98ee3862c James Smart         2015-12-16  3296             break;
> 4258e98ee3862c James Smart         2015-12-16  3297
> 4258e98ee3862c James Smart         2015-12-16  3298     case SLI_MGMT_RPR=
T:
> de3ec318fee323 James Smart         2022-05-05  3299             if (vport=
->port_type !=3D LPFC_PHYSICAL_PORT) {
> de3ec318fee323 James Smart         2022-05-05  3300                     n=
dlp =3D lpfc_findnode_did(phba->pport, FDMI_DID);
> de3ec318fee323 James Smart         2022-05-05  3301                     i=
f (!ndlp)
> de3ec318fee323 James Smart         2022-05-05  3302                      =
       return 0;
> de3ec318fee323 James Smart         2022-05-05  3303             }
> de3ec318fee323 James Smart         2022-05-05  3304             fallthrou=
gh;
> 4258e98ee3862c James Smart         2015-12-16  3305     case SLI_MGMT_RPA=
:
> 2649809cd1b432 James Smart         2022-09-11  3306             /* Store =
base ptr right after preamble */
> 2649809cd1b432 James Smart         2022-09-11  3307             base =3D =
(struct lpfc_fdmi_reg_portattr *)&CtReq->un;
> 2649809cd1b432 James Smart         2022-09-11  3308
> 4258e98ee3862c James Smart         2015-12-16  3309             if (cmdco=
de =3D=3D SLI_MGMT_RPRT) {
> 2649809cd1b432 James Smart         2022-09-11  3310                     r=
h =3D (struct lpfc_fdmi_reg_hba *)base;
> 4258e98ee3862c James Smart         2015-12-16  3311                     /=
* HBA Identifier */
> 4258e98ee3862c James Smart         2015-12-16  3312                     m=
emcpy(&rh->hi.PortName,
> 4258e98ee3862c James Smart         2015-12-16  3313                      =
      &phba->pport->fc_sparam.portName,
> 4258e98ee3862c James Smart         2015-12-16  3314                      =
      sizeof(struct lpfc_name));
> 4258e98ee3862c James Smart         2015-12-16  3315                     p=
ab =3D (struct lpfc_fdmi_reg_portattr *)
> 2649809cd1b432 James Smart         2022-09-11  3316                      =
       ((uint8_t *)base + sizeof(struct lpfc_name));
> 2649809cd1b432 James Smart         2022-09-11  3317                     s=
ize +=3D sizeof(struct lpfc_name);
> 2649809cd1b432 James Smart         2022-09-11  3318             } else {
> 2649809cd1b432 James Smart         2022-09-11  3319                     p=
ab =3D base;
> 4258e98ee3862c James Smart         2015-12-16  3320             }
> 4258e98ee3862c James Smart         2015-12-16  3321
> 4258e98ee3862c James Smart         2015-12-16  3322             memcpy((u=
int8_t *)&pab->PortName,
> 4258e98ee3862c James Smart         2015-12-16  3323                    (u=
int8_t *)&vport->fc_sparam.portName,
> 4258e98ee3862c James Smart         2015-12-16  3324                    si=
zeof(struct lpfc_name));
> 4258e98ee3862c James Smart         2015-12-16  3325             pab->ab.E=
ntryCnt =3D 0;
> 2649809cd1b432 James Smart         2022-09-11  3326             /* add le=
ngth of name and EntryCnt field */
> 2649809cd1b432 James Smart         2022-09-11  3327             size +=3D=
 sizeof(struct lpfc_name) + FOURBYTES;
> 2649809cd1b432 James Smart         2022-09-11  3328
> 4258e98ee3862c James Smart         2015-12-16  3329             bit_pos =
=3D 0;
> 4258e98ee3862c James Smart         2015-12-16  3330             if (new_m=
ask)
> 4258e98ee3862c James Smart         2015-12-16  3331                     m=
ask =3D new_mask;
> 4258e98ee3862c James Smart         2015-12-16  3332             else
> 4258e98ee3862c James Smart         2015-12-16  3333                     m=
ask =3D vport->fdmi_port_mask;
> 4258e98ee3862c James Smart         2015-12-16  3334
> 4258e98ee3862c James Smart         2015-12-16  3335             /* Mask w=
ill dictate what attributes to build in the request */
> 4258e98ee3862c James Smart         2015-12-16  3336             while (ma=
sk) {
> 4258e98ee3862c James Smart         2015-12-16  3337                     i=
f (mask & 0x1) {
> 4258e98ee3862c James Smart         2015-12-16  3338                      =
       func =3D lpfc_fdmi_port_action[bit_pos];
> 045c58c87560b2 James Smart         2022-09-11  3339                      =
       addsz =3D func(vport, ((uint8_t *)base + size));
> 045c58c87560b2 James Smart         2022-09-11  3340                      =
       if (addsz) {
> 76b2c34aeb947a James Smart         2015-04-07  3341                      =
               pab->ab.EntryCnt++;
> 045c58c87560b2 James Smart         2022-09-11  3342                      =
               size +=3D addsz;
> 045c58c87560b2 James Smart         2022-09-11  3343                      =
       }
> 2649809cd1b432 James Smart         2022-09-11  3344                      =
       /* check if another attribute fits */
> 045c58c87560b2 James Smart         2022-09-11  3345                      =
       if ((size + FDMI_MAX_ATTRLEN) >
> 4258e98ee3862c James Smart         2015-12-16  3346                      =
           (LPFC_BPL_SIZE - LPFC_CT_PREAMBLE))
> 4258e98ee3862c James Smart         2015-12-16  3347                      =
               goto port_out;
> 4258e98ee3862c James Smart         2015-12-16  3348                     }
> 4258e98ee3862c James Smart         2015-12-16  3349                     m=
ask =3D mask >> 1;
> 4258e98ee3862c James Smart         2015-12-16  3350                     b=
it_pos++;
> 4258e98ee3862c James Smart         2015-12-16  3351             }
> 76b2c34aeb947a James Smart         2015-04-07  3352  port_out:
> 76b2c34aeb947a James Smart         2015-04-07  3353             pab->ab.E=
ntryCnt =3D cpu_to_be32(pab->ab.EntryCnt);
> 2649809cd1b432 James Smart         2022-09-11  3354             size +=3D=
 GID_REQUEST_SZ - 4;
> dea3101e0a5c89 James Bottomley     2005-04-17  3355             break;
> dea3101e0a5c89 James Bottomley     2005-04-17  3356
> 76b2c34aeb947a James Smart         2015-04-07  3357     case SLI_MGMT_GHA=
T:
> 76b2c34aeb947a James Smart         2015-04-07  3358     case SLI_MGMT_GRP=
L:
> 76b2c34aeb947a James Smart         2015-04-07  3359             rsp_size =
=3D FC_MAX_NS_RSP;
> df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3360             fallthrou=
gh;
> dea3101e0a5c89 James Bottomley     2005-04-17  3361     case SLI_MGMT_DHB=
A:
> 76b2c34aeb947a James Smart         2015-04-07  3362     case SLI_MGMT_DHA=
T:
> 2649809cd1b432 James Smart         2022-09-11  3363             pe =3D (s=
truct lpfc_fdmi_port_entry *)&CtReq->un;
> dea3101e0a5c89 James Bottomley     2005-04-17  3364             memcpy((u=
int8_t *)&pe->PortName,
> 2e0fef85e098f6 James Smart         2007-06-17  3365                    (u=
int8_t *)&vport->fc_sparam.portName,
> dea3101e0a5c89 James Bottomley     2005-04-17  3366                    si=
zeof(struct lpfc_name));
> dea3101e0a5c89 James Bottomley     2005-04-17  3367             size =3D =
GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
> dea3101e0a5c89 James Bottomley     2005-04-17  3368             break;
> dea3101e0a5c89 James Bottomley     2005-04-17  3369
> 76b2c34aeb947a James Smart         2015-04-07  3370     case SLI_MGMT_GPA=
T:
> 76b2c34aeb947a James Smart         2015-04-07  3371     case SLI_MGMT_GPA=
S:
> 76b2c34aeb947a James Smart         2015-04-07  3372             rsp_size =
=3D FC_MAX_NS_RSP;
> df561f6688fef7 Gustavo A. R. Silva 2020-08-23  3373             fallthrou=
gh;
> dea3101e0a5c89 James Bottomley     2005-04-17  3374     case SLI_MGMT_DPR=
T:
> de3ec318fee323 James Smart         2022-05-05  3375             if (vport=
->port_type !=3D LPFC_PHYSICAL_PORT) {
> de3ec318fee323 James Smart         2022-05-05  3376                     n=
dlp =3D lpfc_findnode_did(phba->pport, FDMI_DID);
> de3ec318fee323 James Smart         2022-05-05  3377                     i=
f (!ndlp)
> de3ec318fee323 James Smart         2022-05-05  3378                      =
       return 0;
> de3ec318fee323 James Smart         2022-05-05  3379             }
> de3ec318fee323 James Smart         2022-05-05  3380             fallthrou=
gh;
> 76b2c34aeb947a James Smart         2015-04-07  3381     case SLI_MGMT_DPA=
:
> 2649809cd1b432 James Smart         2022-09-11  3382             pe =3D (s=
truct lpfc_fdmi_port_entry *)&CtReq->un;
> dea3101e0a5c89 James Bottomley     2005-04-17  3383             memcpy((u=
int8_t *)&pe->PortName,
> 2e0fef85e098f6 James Smart         2007-06-17  3384                    (u=
int8_t *)&vport->fc_sparam.portName,
> dea3101e0a5c89 James Bottomley     2005-04-17  3385                    si=
zeof(struct lpfc_name));
> dea3101e0a5c89 James Bottomley     2005-04-17  3386             size =3D =
GID_REQUEST_SZ - 4 + sizeof(struct lpfc_name);
> dea3101e0a5c89 James Bottomley     2005-04-17  3387             break;
> 76b2c34aeb947a James Smart         2015-04-07  3388     case SLI_MGMT_GRH=
L:
> 76b2c34aeb947a James Smart         2015-04-07  3389             size =3D =
GID_REQUEST_SZ - 4;
> 76b2c34aeb947a James Smart         2015-04-07  3390             break;
> 76b2c34aeb947a James Smart         2015-04-07  3391     default:
> 76b2c34aeb947a James Smart         2015-04-07  3392             lpfc_prin=
tf_vlog(vport, KERN_WARNING, LOG_DISCOVERY,
> 76b2c34aeb947a James Smart         2015-04-07  3393                      =
        "0298 FDMI cmdcode x%x not supported\n",
> 76b2c34aeb947a James Smart         2015-04-07  3394                      =
        cmdcode);
> d8cdd33a66dc8c James Smart         2022-09-11  3395             goto fdmi=
_cmd_free_rspvirt;
> dea3101e0a5c89 James Bottomley     2005-04-17  3396     }
> 76b2c34aeb947a James Smart         2015-04-07  3397     CtReq->CommandRes=
ponse.bits.Size =3D cpu_to_be16(rsp_size);
> dea3101e0a5c89 James Bottomley     2005-04-17  3398
> d8cdd33a66dc8c James Smart         2022-09-11  3399     bde =3D (struct u=
lp_bde64_le *)rsp->virt;
> d8cdd33a66dc8c James Smart         2022-09-11  3400     bde->addr_high =
=3D cpu_to_le32(putPaddrHigh(rq->phys));
> d8cdd33a66dc8c James Smart         2022-09-11  3401     bde->addr_low =3D=
 cpu_to_le32(putPaddrLow(rq->phys));
> d8cdd33a66dc8c James Smart         2022-09-11  3402     bde->type_size =
=3D cpu_to_le32(ULP_BDE64_TYPE_BDE_64 <<
> d8cdd33a66dc8c James Smart         2022-09-11  3403                      =
            ULP_BDE64_TYPE_SHIFT);
> d8cdd33a66dc8c James Smart         2022-09-11  3404     bde->type_size |=
=3D cpu_to_le32(size);
> dea3101e0a5c89 James Bottomley     2005-04-17  3405
> 76b2c34aeb947a James Smart         2015-04-07  3406     /*
> 76b2c34aeb947a James Smart         2015-04-07  3407      * The lpfc_ct_cm=
d/lpfc_get_req shall increment ndlp reference count
> e47c9093531d34 James Smart         2008-02-08  3408      * to hold ndlp r=
eference for the corresponding callback function.
> e47c9093531d34 James Smart         2008-02-08  3409      */
> d8cdd33a66dc8c James Smart         2022-09-11  3410     if (!lpfc_ct_cmd(=
vport, rq, rsp, ndlp, cmpl, rsp_size, 0))
> dea3101e0a5c89 James Bottomley     2005-04-17  3411             return 0;
> dea3101e0a5c89 James Bottomley     2005-04-17  3412
> d8cdd33a66dc8c James Smart         2022-09-11  3413  fdmi_cmd_free_rspvir=
t:
> d8cdd33a66dc8c James Smart         2022-09-11  3414     lpfc_mbuf_free(ph=
ba, rsp->virt, rsp->phys);
> d8cdd33a66dc8c James Smart         2022-09-11  3415  fdmi_cmd_free_rsp:
> d8cdd33a66dc8c James Smart         2022-09-11  3416     kfree(rsp);
> d8cdd33a66dc8c James Smart         2022-09-11  3417  fdmi_cmd_free_rqvirt=
:
> d8cdd33a66dc8c James Smart         2022-09-11  3418     lpfc_mbuf_free(ph=
ba, rq->virt, rq->phys);
> d8cdd33a66dc8c James Smart         2022-09-11  3419  fdmi_cmd_free_rq:
> d8cdd33a66dc8c James Smart         2022-09-11  3420     kfree(rq);
> dea3101e0a5c89 James Bottomley     2005-04-17  3421  fdmi_cmd_exit:
> dea3101e0a5c89 James Bottomley     2005-04-17  3422     /* Issue FDMI req=
uest failed */
> e8b62011d88d6f James Smart         2007-08-02  3423     lpfc_printf_vlog(=
vport, KERN_INFO, LOG_DISCOVERY,
> e8b62011d88d6f James Smart         2007-08-02  3424                      =
"0244 Issue FDMI request failed Data: x%x\n",
> e8b62011d88d6f James Smart         2007-08-02  3425                      =
cmdcode);
> dea3101e0a5c89 James Bottomley     2005-04-17  3426     return 1;
> dea3101e0a5c89 James Bottomley     2005-04-17  3427  }
> dea3101e0a5c89 James Bottomley     2005-04-17  3428
>
> :::::: The code at line 3113 was first introduced by commit
> :::::: 4258e98ee3862ca7036654b43c839ab7668043e0 lpfc: Modularize and clea=
nup FDMI code in driver
>
> :::::: TO: James Smart <james.smart@avagotech.com>
> :::::: CC: Martin K. Petersen <martin.petersen@oracle.com>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000d1af0e0600287038
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQZwYJKoZIhvcNAQcCoIIQWDCCEFQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2+MIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUYwggQuoAMCAQICDAx3oGwxIEOxqBUW1jANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTAwNDVaFw0yNTA5MTAwOTAwNDVaMIGK
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xEzARBgNVBAMTCkp1c3RpbiBUZWUxJjAkBgkqhkiG9w0BCQEW
F2p1c3Rpbi50ZWVAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
1FcD8UCLr1YJvSijoRgBcjkrFpoHEJ5E6Cs2+JbaWnNDm2jAQzRe31aRiIj+dS2Txzq22qODcTHv
a67nFYHohW7NbgVOxh5G3h55d4aCwK7NvAGjHFcvNdZ9ECpMOpvGg0Pz/nQVVmU/K6mAGkdtF674
niejyV/sWPwqdts/jpWYEN5/h0shrmgChGnWlAarY2gO018avJp8oVJLbMZ7A4gvs76YPXJYhCha
QsyUohclvlxgt5d/MsBG6WZxZ+uppzNvjEk/wUu+6JQNUVEMviA6eBCCi+4ShjZUbGPES11h5lw/
wuyQZDIjy+1hGPtLHBXI/QQEbU3OVdTRn+aEMwIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdqdXN0aW4udGVlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUlHfvnuNaLp52RO2Y2En9J+7MKI4wDQYJ
KoZIhvcNAQELBQADggEBAGaBsEmLZwejb3YsmigadLZGto3hJ7Erq2YZLhL7Pgtxft1/j4JNLsRN
t3ZJIW2Xzfbj0p328xRekSP1gjZ9Szre0fxEFXH1sS1a7WP9E0fHxVW07xVsxGxo5opAh5Gf/bQH
S4x9pCO48FJI310L1RGQiqFKY/OECnXO821y8MAyObbGo9HNHP4Sk6F5J1v2qJzbLtMfj8ybbTGe
SidstRgjOIqMldZs2Koio14QFE7hJY+8KRiKfq+eb1EwQTMzBxZsMOL5vUSZjYg2+Fqwyr6YYp0w
Lsq/wH9o18xSvL/FikpG4JRxiT20RdM6DQrk9lv8ijASZCuN3JR61WUNz2AxggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwMd6BsMSBDsagVFtYwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINSjDzx04d9GsSRNABOByAckxsQhM3Oeg5aCTHjq
mSDlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDcxMDIxMTIz
MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQBVxdCQ29AdPBrG2QNmwSAaRBW1byorOjHxZtMz2ztOVnDIlXZmYXAYIdV0
K4ZjVKPaZZpnheVRiDZU2PbQMVK5xq7QalzFWhw51XvuH8zxTtqlDSpD/gMm717rV0uXbMaTAKN4
XZVF2OUtsVG1aVuc26ohMSvbzWkn4QuarTW889bk36XvU/Da2Mba8TSPWFCxi0iQMiURSXLyYOll
WVWKja1kxK7d54Jyuevd2DgjhmTTjQNMs3ISUFLHkL1nsRl13urVsLFrKdDLglN2SrXY57E/eFZX
n1VT5z7Yao9GJPdGmeJ35EibadvXCwffHm91bkV7SfWBwe+6LEbJK0Q8
--000000000000d1af0e0600287038--
