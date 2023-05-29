Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1743C714912
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjE2MID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjE2MIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:08:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2093.outbound.protection.outlook.com [40.107.102.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC785A3;
        Mon, 29 May 2023 05:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIwKNZyoQZ70srf7qL1l4FmLwFomZhrplPFItrnBTRfG87GxYcFtazwABoT7fO1s1UPAxqC7fkq3s6sC0UgyKp1BwC0kS7LhEhNz0qV7+TUMwWpysHnylTYFWsCXEKQOL80QDE1qHRkLBCI5vYy/qs/MCYd2ZOseL3Aovrne6L0Jh/AE4H1R8wjZDf6EgAB5gSR63+g8q+UATeUe7YAhu2b1Hokg8qN86hrdc8/eyNv/bonwmIWDKzdBlf5dn6b8LMda1UxFe4A/Bl6SLKDC3RtOTVzNvzZGaAksH1gdE0LYsSgA0lGXc5u6FNhKiJsta8zwV+tq73Xe4z6E4iIU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61maz6anAFrj4mN/losfDVyafPG+Qi7wn3MMcVBHUQM=;
 b=h5XmST1WFWpOBIiaxa2BBkpoEjt1H4zzjcYdnC1U5+9IxgOY7hX140wcjYIn6qOWkhzN+ibpuQrkupt5W1qdDyyEI1mp9nhs5WLDIUKiP6GAoEzlcfM0hCFkNY2xigmYlV3orm/i5ZR1aitzOqhReSsWDBDQNcyeycpFtC+7w5iAjVLftIuNjch2N6CnDNMednT5czjVzJUAIZmbgD69RPVVkl8Y9jFe/tRG1LBwseMjFPrIzNz7pjgtckHjuQ2lbhqxFt+ne5wtWuGTXYgs98ybkN8+5uNE6zGNvYNsp73RDL1AUhTeZrK3sKB1dtjv5+IAyawsOFp0M94t+XplUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61maz6anAFrj4mN/losfDVyafPG+Qi7wn3MMcVBHUQM=;
 b=uTBMgAOD0c4dn7WZglMQkPHF9JVdeq/StQTBwNX0mj1GpwKxevgH4Q6RM3bATRUl4MeAG8Pbfgu0uXgrtBrJsEqOsSw8D3r8lTucx5/atQbbPiU0TCZ3sjlMnoLcVkQ4Br24JQjpWnG7ZfZL9Rnz0bbhsQbhxXQApAfa40J/sgE=
Received: from DM4PR16MB5004.namprd16.prod.outlook.com (2603:10b6:8:43::15) by
 DM6PR16MB3863.namprd16.prod.outlook.com (2603:10b6:5:2be::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Mon, 29 May 2023 12:07:55 +0000
Received: from DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::a733:90e1:bd47:cf69]) by DM4PR16MB5004.namprd16.prod.outlook.com
 ([fe80::a733:90e1:bd47:cf69%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 12:07:55 +0000
From:   "Chevron Li (WH)" <chevron.li@bayhubtech.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Shirley Her(SC)" <shirley.her@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Justin Wang (WH)" <justin.wang@bayhubtech.com>,
        Chevron Li <chevron_li@126.com>
Subject: RE: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
Thread-Topic: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue
 when 64bit DMA mode is used.
Thread-Index: AQHZjWdihWBVzy0abUm9tKKNGHDpg69xMEgA
Date:   Mon, 29 May 2023 12:07:55 +0000
Message-ID: <DM4PR16MB50042A8535E8A9DF16B0C190EA4A9@DM4PR16MB5004.namprd16.prod.outlook.com>
References: <20230523111114.18124-1-chevron_li@126.com>
In-Reply-To: <20230523111114.18124-1-chevron_li@126.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR16MB5004:EE_|DM6PR16MB3863:EE_
x-ms-office365-filtering-correlation-id: d252d09a-adf9-467c-15bb-08db603d55e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yv1O4hdG3eKM04tj9EHJBUzoKQCTaqjn5u1OCVksU56Y69tMycKIOxy/TqwBEMlOjME7hTeO2obVmr/3wWKPa1btEGrTPziPYdhu4NeOFiuvWlUIxpQkaz9NOlKARLV2n4ZZOAtB3EgYE3UHuLkFJc1ddvsAfavVU/H1huY+2qR1zES7rwA7h6pxyJMkQ/JkWkTqiZGlb27vbXIN1PKra5D4A97LEgLD8L+IUYQGaDT1LdEk/kqx/HQMFcWP8DhwD2OvD0OIHx73Oygiyjlv/eedmSftgdpP4mmCiK+3yjG2NGrXGmbqyF7s4lQ6JsWdlt2wuCcxxWcry1lYHP8KZEmmdhX8bfvliDI1ZbMKGusqSgZttjx20O4G81pwhjoimyD38YG1q/5o35ly1CoG0j6gAdIDyFJUDIWcSzdakDhE/VFzyMbQnABOZw9oDmPY7/Ht4ItYl2Cb3ppke/VT1rhFc9TZx9dklM8co7JT2ifKQ/tv7sdebhO6n6/Gf1NAQs9qMPtz+XuHAZouh2PtsSN/tYrlABSoSwEtGir7vJx/Sugjm64x3TDd6Xuv7ZefjCTsOXtst4Pe5ahByNtrGbqH8fwWHARRfAMMe9jUEeI03Sx5NefRUOWbL8BdLE9F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR16MB5004.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39830400003)(451199021)(41300700001)(86362001)(7696005)(38070700005)(55016003)(64756008)(66446008)(4326008)(316002)(33656002)(71200400001)(76116006)(66476007)(66556008)(66946007)(52536014)(5660300002)(9686003)(6506007)(26005)(83380400001)(53546011)(186003)(2906002)(478600001)(8676002)(8936002)(122000001)(110136005)(54906003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WTuDpktcXIViarhbHKaXcEHcU5VJNIE+3HORFbj6Vc1T9hXm950MsX7kXDwb?=
 =?us-ascii?Q?QCv6RynTDgyL2iB1ev5BtUBrLW7btCmpBPQ2565nTxB1zZfZosIRk3yKBEY3?=
 =?us-ascii?Q?L2athOuBCLh2b48vzuFyCvpyQ2wOHv0fym7iNVIdu+sGds0ypnHqntpALmzp?=
 =?us-ascii?Q?4g9BDWzQBeYAXBJgJuBe03IknUJJt0Z1CzAloiWDn3BhNx7LlrUikqwCAP53?=
 =?us-ascii?Q?vNuOKs7bgfKbqqw/aZB7abRDrF3p1Nb3MJKLiokeLKxFlar8Ri1dhMDZAj+r?=
 =?us-ascii?Q?jGNNxAyUEHGID5/dOc6O64DD3pfjm4B8UAkfDGnBdd7PO8YY0E+p4JA2rU3p?=
 =?us-ascii?Q?CRaZIIgLAy8tyusDBWN9887Dql+OAAhdu9Uidr7mwSuL+3Z3a1DeLz1o0tL4?=
 =?us-ascii?Q?uWVTYee8oexWOYCwefXC2vCM4iSoVXedMvgXRGIRrw+AolDeeYH74jdW+qDX?=
 =?us-ascii?Q?oRwxJSZ3jqEHktdJyMHEiaHp88q3n/Q+82Ckv/TD6RQsVCMnjmaEXGfGFVMe?=
 =?us-ascii?Q?nseCUJzeozDAol0luAfX2z3X+rG6rGQxA2hUfDi3tv8ohbSdBLlbAr+JqkOY?=
 =?us-ascii?Q?ugGiHXe6Bp6KDahmmLsxfKmGOMEHpkrHzkri3zjNyvTYk+ZwPcIy+4fSdGaY?=
 =?us-ascii?Q?+RO2GiWINjhuMgc6EKu3kEy0voJHt2C2UU+TU1c8xOsR6J9E9pozj2jGRBYe?=
 =?us-ascii?Q?F7mZ8r5Fyr6bCJPJVVqUGjEKOwXIyNbVQ/reobX/TH7HLKfow9ijdueT/J2y?=
 =?us-ascii?Q?hjL230kZ/AFd0Z26kAlVQbMNTKgCiqgXciS5RpDs3H1hTM8N+cU1D6/ivqbY?=
 =?us-ascii?Q?lrfzt6N5eMuTs6GTwMlbLdMskhEy+ZyNzifV7jax6jld1Ew5KRW6jX03No/A?=
 =?us-ascii?Q?JIiTkc3qpYEvfUzV5DhY0/VVipLlBpZB1zdGf3yEVyq9bzsrVYkdoy6fu+A5?=
 =?us-ascii?Q?8Z2vsiJPHY5lHGC9l3MUL0gFCINvutQQxUNMoPXMjjzWAIZwda5Pa9yqN/lN?=
 =?us-ascii?Q?4b+Fbd78LRDoNNY/yxTfkvrX/lEQH9poJ6dDgScq3T6G6zeCV5jFJNU+yKV5?=
 =?us-ascii?Q?eZmP9g65HwPf0mer+iMtoMnHHY/d1XhyEJ+XbflB5n6AKjmwNZvywOTYaFw0?=
 =?us-ascii?Q?1NQcOdPvVv35uzpqUSdTplZHM3Crh8G+owgc5AhBDlIuaMPaR66Gnye8lEjf?=
 =?us-ascii?Q?tdjFpS4YkwYgHi3tscjweS5gSh9j78aIaUAbb3tzUmyHe9tgXDI378soyJmu?=
 =?us-ascii?Q?2cK3tBlPUBdULoocUrIbLWBhko2zDZjhBsWBlBufuj0nQSrrZS9/wS9Ung4G?=
 =?us-ascii?Q?vRUBTj7AOOPIyTJXSOLhKtnqEafWkA5V5mAua8lAe2Hl7XdIpcAD1kt2O0rS?=
 =?us-ascii?Q?1pu3HYZ7X/FwAqyBCoS6YzMfQNCZXOxZVWBANrdw8DlAfehHBRTGxZs1MTAp?=
 =?us-ascii?Q?NYA8OCa1gjD4MwiZbWVo3TKPa0BbBxruScI+Yf/8VdJHM010GdpAFMR1YojF?=
 =?us-ascii?Q?FqQ5mawDvlHI4kISU/2HcEXs58Jd+AVPfxW11OEjpHAowabFhArdq8XB7v4w?=
 =?us-ascii?Q?d/TfNwCj6Y8Zs9dY+VhsNk/sbPS/e2L0VhSwGp/z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR16MB5004.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d252d09a-adf9-467c-15bb-08db603d55e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 12:07:55.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZuJ5P8X05NG+yZ70V8HfcO/IPtUjeubw1rMM/7iDIbggBIV1ICsb+EYV7c/vw9TjR2EM9eE9gz3YkEAzcsjDXILsuy/9aObP6mRf0k8B5ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3863
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian/Ulf,

May I know the patch progress?
Look forward your response.

BR,
Chevron

-----Original Message-----
From: Chevron Li <chevron_li@126.com>=20
Sent: Tuesday, May 23, 2023 19:11
To: adrian.hunter@intel.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.=
org; linux-kernel@vger.kernel.org
Cc: Shirley Her(SC) <shirley.her@bayhubtech.com>; XiaoGuang Yu (WH) <xiaogu=
ang.yu@bayhubtech.com>; Shaper Liu (WH) <shaper.liu@bayhubtech.com>; Justin=
 Wang (WH) <justin.wang@bayhubtech.com>; Chevron Li (WH) <chevron.li@bayhub=
tech.com>
Subject: [PATCH V1 1/1] mmc: sdhci: fix DMA configure compatibility issue w=
hen 64bit DMA mode is used.

From: Chevron Li <chevron.li@bayhubtech.com>

Bayhub SD host has hardware limitation:
1.The upper 32bit address is inhibited to be written at SD Host Register
  [03E][13]=3D0 (32bits addressing) mode, is admitted to be written only at
  SD Host Register [03E][13]=3D1 (64bits addressing) mode.
2.Because of above item#1, need to configure SD Host Register [03E][13] to
  1(64bits addressing mode) before set 64bit ADMA system address's higher
  32bits SD Host Register [05F~05C] if 64 bits addressing mode is used.

The hardware limitation is reasonable for below reasons:
1.Normal flow should set DMA working mode first, then do
  DMA-transfer-related configuration, such as system address.
2.The hardware limitation may avoid the software to configure wrong higher
  32bit address at 32bits addressing mode although it is redundant.

The change that set 32bits/64bits addressing mode before set ADMA address,
  has no side-effect to other host IPs for below reason:
The setting order is reasonable and standard: DMA Mode setting first and
  then DMA address setting. It meets all DMA setting sequence.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
Set dma mode configure before set dma address
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index 3241=
916141d7..ff41aa56564e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1167,6 +1167,8 @@ static void sdhci_prepare_data(struct sdhci_host *hos=
t, struct mmc_command *cmd)
 		}
 	}
=20
+	sdhci_config_dma(host);
+
 	if (host->flags & SDHCI_REQ_USE_DMA) {
 		int sg_cnt =3D sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
=20
@@ -1186,8 +1188,6 @@ static void sdhci_prepare_data(struct sdhci_host *hos=
t, struct mmc_command *cmd)
 		}
 	}
=20
-	sdhci_config_dma(host);
-
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
=20

base-commit: cc3c44c9fda264c6d401be04e95449a57c1231c6
--
2.25.1

