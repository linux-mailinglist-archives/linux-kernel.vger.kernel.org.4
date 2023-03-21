Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3152B6C30F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjCULzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjCULzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:55:06 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D525E11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1679399675; i=@lenovo.com;
        bh=21SeLlrg/7GqLKPZI26J406zIGMQ4V+3cYHvnVS+VQU=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=VHnc0sg4d1s2esoKwTv3E0/b1D55H1V/iMxtVwYABxQfkD2rQw9dwucmV2i7Nfscg
         ZJJEzibVFBEFI5Iv2+CeL5D29rqrFkT8t5ZKLLgo/ayVe0svXvvFIAb7BCMmdO7P7S
         uyIK7RKMkTubPNHSo7GZuUfH1c0b6izqEj/vrN7pkYzuUQ1WK3IwDzVOzgDBoabiaR
         IrUC/Nz26kvo1UiHSmu4y0yVAA+nOlhbFpTZDSXNTedpNSBKoyIxs+VSADZ9fPLwR4
         k5LqdoJ9gmRUFrKANYZYr0HCeVu2IIfWwoYuUaRBBGhybBMEMPpDRQbwS3+i1HpMff
         X7NZGhMM9zq0w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRWlGSWpSXmKPExsWSoS+lr/tplmS
  KweIeI4v/e46xWXzoXMNosXL1USaLSYeuMVpc3jWHzWL+sqfsFutev2dxYPeY2PyO3WNBz3lm
  j/P3NrJ4bFrVyeaxeUm9x+6bDWwenzfJBbBHsWbmJeVXJLBmNC7xK/hnXnF54Uv2BsYF5l2Mn
  ByMAkuZJRY8celi5AKyF7FKtH6bygThbGCU6P71mRHEERKYzySx6+gtdgjnPqPEie4bLCD9bA
  LqEotmnQZrERHoYJTYvauDBcRhFtjKKHHywkRmkCphgWyJWWu+sYPYIgI5Ehc/32HrYuQAsq0
  kFp8tBTFZBFQlLi8Cq+AViJV4t+oLE8SyiYwSD340soIkOAXsJXZuW8UKcbisxLRH95lAbGYB
  cYm502aBxSUEBCSW7DnPDGGLSrx8/A+qvkTi1sv1bBBxWYlL87sZIWx7iYeLvkLFfSWeL7/IB
  GHLSazqfcgCYctLTFv0nh3ClpF4cGM7G8hxEgJ72CR6L/xhhHAus0i8+XgNarOBxLxvR6Cqbo
  hI/N40gRHkTWYBTYn1u/QhrlaUmNL9kH0Co/YsJE/MQqiahaRqFjhgBCVOznzCsoCRZRWjaXF
  qUVlqka6ZXlJRZnpGSW5iZo5eYpVuol5psW5qYnGJrpFeYnmxXmpxsV5xZW5yTopeXmrJJkZg
  MkspcnDbwbig76/eIUZJDiYlUd5fJpIpQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4784AygkWp
  aanVqRl5gATK0xagoNHSYT38zSgNG9xQWJucWY6ROoUoz3HlW179zJzXL1yBUheW79gHzPHii
  VTDzILseTl56VKifNemwnUJgDSllGaBzcUlgkuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBL
  m7Z4ONIUnM68EbvcroLOYgM6KmyEBclZJIkJKqoHJ9pEM4+H2SXvyvTkDOeu+bs9La3CwX1eb
  kWj39rrVup9eEz/0cfXu2aY60X8205p/xiXNm+tWMkmXndLOPfYm6cm3kBj35LdXDSoKld5+T
  Jkfz9c9NaAusOmsrQPD9VrVtogZWcEtL9rk3s9Q1Xe3C8y3DKr3NzTiPraV4UvC6XkTf838/N
  g0/I34HcUev5tbqmI+KzpuDjw0pdd55u+wyF1vxVf4BGbkbb3qtLS8aufP6r4DJ0QrGV1db9Z
  93ZeZ3+io93W/TfHJ9S+iTuRUq3l5yaYvlvrZsmla15dMrUXis5hZvWawLFY9+7jq7oSV1Ryy
  LRxXknyK60W/7RPt+MS8Z6KLQtLVd4lSBUosxRmJhlrMRcWJALPlPB5/BAAA
X-Env-Sender: yinlei2@lenovo.com
X-Msg-Ref: server-3.tower-715.messagelabs.com!1679399665!84905!1
X-Originating-IP: [104.47.26.47]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4653 invoked from network); 21 Mar 2023 11:54:26 -0000
Received: from mail-psaapc01lp2047.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.47)
  by server-3.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Mar 2023 11:54:26 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFl7d/U3O3SKNNlPHiakzbjKd32It8Y0xUyek7BUXh9UwUU+s2ZMQrnIW78ZlgXdatBlF5er0qo3q+L8pBMNhhoA7hsbmSSDwQuk8VaotK/p5/IuATB/NL2Lpl05/BxFwN1uyb+rLu6ao9aNsREwKG3QWZXya1x3uYmbFOU0eCPB95AR+uhsNzO5RELrDRHHIHqzZjgRMSEcw52jtyge/9bj92VdN4EL0rka7TcGjET1+Z1np0zXaPoQKUj9kWWBdMzfJYsVEZCADDzqq4tLbmrhMsaPoAt9jpgBEtGMlnimkhgWexcCDr5H2nrOfv/ND/pGDXWWeEpvtkQBqP9kbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21SeLlrg/7GqLKPZI26J406zIGMQ4V+3cYHvnVS+VQU=;
 b=BKLyghTT9YiJWdqjTZ5zaQGYQiBTmPJat/34lJpb2UGJqSYziuPCZHMYYnNOkDQloJ3iNc9qydiLa8roA1ozoyt63hFSNhUCTDrUD577vj6Is3p6sSyvYaGiqjfT5pD/gnNLx8O7QGv+l2B0Ynsx+9IYw1U0Gi6q7gcTm0sM/Nrk0VGszxNgQ6JDiQsT7pCGkA7Uvbgaa38P2+Z32w2aL7OOdKRPtdcyO3j2GHiZPcm6uhZG71MDHAM7l7deMGAge1YTM44iTgxozjgETmQqjxxUtZJd9oVvuELJyyEo4glOCj3q3godiJM9xe5/V8J41RhCKTLLV7VJovE/Nnx+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com (2603:1096:300:84::21)
 by KL1PR03MB6923.apcprd03.prod.outlook.com (2603:1096:820:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 11:54:23 +0000
Received: from PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9]) by PS1PR03MB4939.apcprd03.prod.outlook.com
 ([fe80::6f60:2bd9:5f36:c4f9%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 11:54:23 +0000
From:   Lei Lei2 Yin <yinlei2@lenovo.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [External] Re: [PATCH] nvme: fix heap-use-after-free and oops in
 bio_endio for nvme multipath
Thread-Topic: [External] Re: [PATCH] nvme: fix heap-use-after-free and oops in
 bio_endio for nvme multipath
Thread-Index: Adlb4qYZRCgfva2qSAaoRzaKM2NfXgAAuViAAAGVKVA=
Date:   Tue, 21 Mar 2023 11:54:23 +0000
Message-ID: <PS1PR03MB49395AC5BC73DDDA6A79E87488819@PS1PR03MB4939.apcprd03.prod.outlook.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
 <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
In-Reply-To: <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PR03MB4939:EE_|KL1PR03MB6923:EE_
x-ms-office365-filtering-correlation-id: e2c63a42-8b2b-4113-b355-08db2a03036e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZjsncc2nI8H1ME8RHK2tSvXSsJDhZCzCLM5weNL0hfK4URWvvmfwVkQ3FIqDGu1QI85+qX7AcbVYWoScYE1XKOokr46aKzAFL+k09lNSXKKwY9a+gHQ5ZVtBrcfFL7Nm8BhfQLX3Kzn3WzBNKzqb2VrOaWX7KEULwgeNglOs0X1IuHadvu7VpCi3CBcqAdzhjWCZZ49yvJmuRXVqriNxZj6U042E7BoZjC3c5/9L1jjrIJXb/2RuvYdXEayWjrpFiGHJ9oPRGlrFND5aKSjp+gy+UA3nKmEwEDDJyAq5DGvpNKWorTo/DAvTFauOI9Of9KUEcCwTvKRxdm58571KgAcl1fFk5y/mbNbd9vCJ6Kw3gJtzN0Q5ZAQVrh4ye+PaVYcyegENaVqKVdWZBrrZuZQeEd1jsdW3R9MmPYV0XCqHRdv6UOI8Mw8uxZF9Hr0ptJLPQ9mn5JQbF8CNJMb8I4qha0i1+apoMia3FKdoGBjSgSQSmzIA2APAs27SJTh9uDYj4/hdY+S6GhLR35/bdVOdBqUsdMRsaMEhQBUTPh2UDRUmULv2HcU9Xymp87UM1ifyQjqcUnE2CtG3h74oeSD7o0SxcrMHmfOu9W5VFaV/a9iIAE2BMZs2xJ3FhaB9MU+CMdgrqR/ItmyidnHu9tON0sePIGLgQrVjCAs/HMyyWYl32mpYsmFMraH9W8o+3Z9IjGJq29uMNR6SjUkc/S3xxtZaCEFT99Sg1aHytQKkFC+Ya9xJ+VZz4KO3yqfFswNU5fq/c/GfthdAgp4uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PR03MB4939.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(186003)(9686003)(478600001)(7696005)(26005)(8676002)(83380400001)(6506007)(54906003)(53546011)(110136005)(316002)(66556008)(71200400001)(66476007)(66446008)(66946007)(64756008)(76116006)(52536014)(8936002)(5660300002)(41300700001)(122000001)(38100700002)(4326008)(82960400001)(2906002)(55016003)(38070700005)(86362001)(33656002)(48020200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1lMZWx3ZXoxczNEdm9NTkRXVUc1ck5iYXpBdEprODRuTFg3cWs2QklHN3Ra?=
 =?utf-8?B?R3BIZmMzMGxXdEMyRlh2b205TWxWbFVKWHhZeVp5dm9lQ3RUVHFjdUxZSUZu?=
 =?utf-8?B?SXVwaXpKNkhRSGxrY3Z1UW40cTIvaThVUVVXd3BxUXhVMXpBdVpyM0MwVVp6?=
 =?utf-8?B?Si82NElOaDRpTmVwVGhkRVljbUZVMVAyQmFhbjJFdzJ0WjNybGhZdFZpMlNV?=
 =?utf-8?B?NnlMK0RzbWdEWW1vWS90VkNIQnVJbFUxOElkaldaVkphdENySGw2WFVXTU8v?=
 =?utf-8?B?Mkk0cFNkUDBUQjJWei9ZRmJ2dmxaN0Jza1NNMWh0RzRTRFg4VGpkU3hUOUtO?=
 =?utf-8?B?cU5KbFRuSXgyZlVjWS9DZGtNeXhaTjFJamV6ZzlvL0JUU01hbkdNdmJMMi9y?=
 =?utf-8?B?UFVQTWhOWnprNlpKNkgvSERTOThrNHJTZGFRcmk3aW5aOEw5azFmZFBoTXlS?=
 =?utf-8?B?OWlsbHU3SnBmV1ozaVB0UWtPKzVtZGZRVlYzRnpmUXFNYmxiZVpZVkpHajA3?=
 =?utf-8?B?Qmx5THBUaTQ4L2g0N21JaDQxdDdCQmR5eGdYanJrUHhRc3g2cmxtaFN3S1JC?=
 =?utf-8?B?REtTVzVHeS9jSTM1dTlkVDdrQ3FibDlEQUJZclA2eWZpOFBoQVBuRUMrUjF4?=
 =?utf-8?B?MDA5WGNBWlYrU2lqeUdOcjc2ZTBOaW1RdCtleDBJRkg5VzhyajYwcGRCWXE2?=
 =?utf-8?B?OHROZ2I3M2VXQXlHSTJPRlZiU2pTdVJHWHVoQjExZCtlbk1tcTA5VU0rbms4?=
 =?utf-8?B?QUxGaHlvTTFjbHRsMklPcWhvV1A1aTJYR20weFJTNXlnTTNsYlZUaEtCcGZp?=
 =?utf-8?B?ZjRpWWF2Z2t5RTZDS0llbEtObmc2SGNwNXE2SFlGTDJibktVUFJqUFdKSGdO?=
 =?utf-8?B?QWkwQVhGV0tNMEd3dE1MWld6dmRaZ25yRUtqcmNTWjhScEl2TVJVeUQwVGlX?=
 =?utf-8?B?UGFJaEw2cjdEai83MTZvMmpHeUpBUnFaUXpiZUdiYnJueHpGUmJsVFhFQWh1?=
 =?utf-8?B?aXdsSGRxcGV6bGI2N1E2ZUNaWVgrZHpPSHFLRFFtbTZCdDZMYVpKV1JMakRL?=
 =?utf-8?B?NExadERGSHhRQ0FhUXF1VzJnUHVtMzJnY25YKzUyMU1UQ05KRzFpZHdLYkt5?=
 =?utf-8?B?YmcrSHVGcWh6YUxEZGdEWW5YeHBoWGtqZG8zUXB6amFTdER2Z3J5ZDB2REU1?=
 =?utf-8?B?djhnRDVrK3dDNkVTejdjV0RqeTJFVGtZR1R1QUJiSXgvZzgzUnZreXMvTGJP?=
 =?utf-8?B?ZFFlZXJmU1dGSDFMTlhlS0pRS0w1MVBuTHJDQjhXOG5wOVBzekNxRlV6aGtL?=
 =?utf-8?B?TUxtTGpxWUVwaU1VbzJIWXlWZUFKSmppai9lNHVXQXhqUmJvRjkvR3gvM2xZ?=
 =?utf-8?B?L2hWeXVjR0tobnBEaHp5QklVQkNacFJDWXZhVGhrTndla0xmTUU4SzJXVlJa?=
 =?utf-8?B?UTdQOVFLamJCVmx0eFM0c3pqQkdsa2xqMTRUcVhZV1lsTG9FQm4zVmNrbHd0?=
 =?utf-8?B?S2lOb2xIMHJLSFJVdE5BWkRlQ3VIOEY2b2JaNjR2eXFveitRa2V3emwybXI4?=
 =?utf-8?B?dEJmYUJPeVYyU1lhUmwya3k0aFlZbzdmZlJuSU5rOCs4SEtrSktFRndYaDll?=
 =?utf-8?B?RVV3ZnpHSmRzUHJia0FVU1p2OEppZkJnL25CYUEwTWowZEw1WFY5c1c0TlFQ?=
 =?utf-8?B?WmJ6VmJNZFNTWSt6a0VxcUdCMSs2RG56U1lPdTR1cXBESW4rSVJ4OFp2MFBE?=
 =?utf-8?B?RlAzKzdHa09obTRxdkFjdnJVOEpSd01UUWNvaTlrdHdQOWU1MkVwYW9WeVdJ?=
 =?utf-8?B?UVkyVTBoTThhY1FsY2hTbVhEcGVkSXhiQmw2RWxwMHAvVWVPa0xDN0lTRkJU?=
 =?utf-8?B?a0hyOTdHcXlJdmdiSGZydWE3Vk1jZlhQR0dmTU94MWVLODduS1VJRnRhK0Na?=
 =?utf-8?B?UnhudTlBdEk0Zld4YmlXeFhwdS9EdDY5Zkp4WVZhR2dPTjlYakpoZVlQclI0?=
 =?utf-8?B?ZkhzMXlqY0NFS3N1dm9qdVJIWU5Jd2VUdFpNb2F4SGhjOVJDaG5yR2tCS2Qv?=
 =?utf-8?B?WGRhZWdJN1NNMERZZkpJV1hwM1hOWGRuSEJOVytXK1plSjFCNlVpWHRoSUFv?=
 =?utf-8?Q?ZZM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS1PR03MB4939.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c63a42-8b2b-4113-b355-08db2a03036e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 11:54:23.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDuVuqIyhxxbgnA9T7U9qdyZEuOc5FxW9Eu+ZTZrA/178NOVf44c5mIvPzN+RH56kcFA1Vo3vgK0y0yGPGS05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6923
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CVRoYW5rIHlvdSBmb3IgeW91ciByZXBseQ0KDQoJVGhpcyBwcm9ibGVtIG9jY3VycyBpbiBudm1l
IG92ZXIgcmRtYSBhbmQgbnZtZSBvdmVyIHRjcCB3aXRoIG52bWUgZ2VuZXJhdGUgbXVsdGlwYXRo
LiBEZWxldGUgdGhlIG5zIGdlbmRpc2sgaXMgY2F1c2VkIGJ5IG52bWYgdGFyZ2V0IHN1YnN5c3Rl
bSBpcyBmYXVsdHksIHRoZW4gaG9zdCBkZXRlY3QgYWxsIHBhdGgga2VlcCBhbGl2ZSBvdmVydGlt
ZSBhbmQgaW8gdGltZW91dC4gQWZ0ZXIgY3RybC1sb3NzLXRtbyBzZWNvbmRzLCBob3N0IHdpbGwg
cmVtb3ZlIGZhaWwgY3RybCBhbmQgbnMgZ2VuZGlzay4NCg0KCVdlIGhhdmUgcmVhcHBlYXIgdGhp
cyBwcm9ibGUgaW4gTGludXgtNS4xMC4xMzYsIExpbnV4LTUuMTAuMTY3IGFuZCB0aGUgbGF0ZXN0
IGNvbW1pdCBpbiBsaW51eC01LjEwLnksIGFuZCB0aGlzIHBhdGNoIGlzIG9ubHkgYXBwbGljYWJs
ZSB0byBMaW51eC01LjEwLnkNCg0KCVllcyAsIHRoaXMgaXMgYWJzb2x1dGVseSB0aGUgd3Jvbmcg
cGxhY2UgdG8gZG8gdGhpcyAuIENhbiBpIG1vdmUgdGhpcyBtb2RpZmljYXRpb24gYWZ0ZXIgbnZt
ZV90cmFjZV9iaW9fY29tcGxldGU/DQoNCglEbyBJIG5lZWQgdG8gcmVzdWJtaXQgYSBwYXRjaCwg
aWYgbW9kaWZpY2F0aW9ucyBhcmUgbmVlZGVkPw0KDQoNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0t
LQ0K5Y+R5Lu25Lq6OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANCuWPkemAgeaX
tumXtDogMjAyM+W5tDPmnIgyMeaXpSAxOTowOQ0K5pS25Lu25Lq6OiBMZWkgTGVpMiBZaW4gPHlp
bmxlaTJAbGVub3ZvLmNvbT47IGtidXNjaEBrZXJuZWwub3JnOyBheGJvZUBmYi5jb207IGhjaEBs
c3QuZGUNCuaKhOmAgTogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBjeWJleW9uZEBmb3htYWlsLmNvbQ0K5Li76aKYOiBbRXh0ZXJu
YWxdIFJlOiBbUEFUQ0hdIG52bWU6IGZpeCBoZWFwLXVzZS1hZnRlci1mcmVlIGFuZCBvb3BzIGlu
IGJpb19lbmRpbyBmb3IgbnZtZSBtdWx0aXBhdGgNCg0KDQoNCk9uIDMvMjEvMjMgMTI6NTAsIExl
aSBMZWkyIFlpbiB3cm90ZToNCj4gIEZyb20gYjEzNGU3OTMwYjUwNjc5Y2U0OGU1NTIyZGRkMzc2
NzJiMTgwMjM0MCBNb24gU2VwIDE3IDAwOjAwOjAwIA0KPiAyMDAxDQo+IEZyb206IExlaSBZaW4g
PHlpbmxlaTJAbGVub3ZvLmNvbT4NCj4gRGF0ZTogVHVlLCAyMSBNYXIgMjAyMyAxNjowOTowOCAr
MDgwMA0KPiBTdWJqZWN0OiBbUEFUQ0hdIG52bWU6IGZpeCBoZWFwLXVzZS1hZnRlci1mcmVlIGFu
ZCBvb3BzIGluIGJpb19lbmRpbyBmb3IgbnZtZQ0KPiAgIG11bHRpcGF0aA0KPiANCj4gV2hlbiBi
bGtfcXVldWVfc3BsaXQgd29ya3MgaW4gbnZtZV9uc19oZWFkX3N1Ym1pdF9iaW8sIGlucHV0IGJp
byB3aWxsIA0KPiBiZSBzcGxpdGVkIHRvIHR3byBiaW9zLiBJZiBwYXJlbnQgYmlvIGlzIGNvbXBs
ZXRlZCBmaXJzdCwgYW5kIHRoZSANCj4gYmlfZGlzayBpbiBwYXJlbnQgYmlvIGlzIGtmcmVlZCBi
eSBudm1lX2ZyZWVfbnMsIGNoaWxkIHdpbGwgYWNjZXNzIA0KPiB0aGlzIGZyZWVkIGJpX2Rpc2sg
aW4gYmlvX2VuZGlvLiBUaGlzIHdpbGwgdHJpZ2dlciBoZWFwLXVzZS1hZnRlci1mcmVlIA0KPiBv
ciBudWxsIHBvaW50ZXIgb29wcy4NCg0KQ2FuIHlvdSBleHBsYWluIGZ1cnRoZXI/IEl0IGlzIHVu
Y2xlYXIgdG8gbWUgaG93IHdlIGNhbiBkZWxldGUgdGhlIG5zIGdlbmRpc2sNCg0KPiANCj4gVGhl
IGZvbGxvd2luZyBpcyBrYXNhbiByZXBvcnQ6DQo+IA0KPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXIt
ZnJlZSBpbiBiaW9fZW5kaW8rMHg0NzcvMHg1MDAgUmVhZCBvZiBzaXplIDggYXQgDQo+IGFkZHIg
ZmZmZjg4ODEwNmYyZTNhOCBieSB0YXNrIGt3b3JrZXIvMToxSC8yNDENCj4gDQo+IENQVTogMSBQ
SUQ6IDI0MSBDb21tOiBrd29ya2VyLzE6MUggS2R1bXA6IGxvYWRlZCBUYWludGVkOiBHICAgICAg
ICAgICBPDQo+ICAgICAgICA1LjEwLjE2NyAjMQ0KPiBIYXJkd2FyZSBuYW1lOiBSZWQgSGF0IEtW
TSwgQklPUyAwLjUuMSAwMS8wMS8yMDExDQo+IFdvcmtxdWV1ZToga2Jsb2NrZCBudm1lX3JlcXVl
dWVfd29yayBbbnZtZV9jb3JlXSBDYWxsIFRyYWNlOg0KPiAgIGR1bXBfc3RhY2srMHg5Mi8weGM0
DQo+ICAgPyBiaW9fZW5kaW8rMHg0NzcvMHg1MDANCj4gICBwcmludF9hZGRyZXNzX2Rlc2NyaXB0
aW9uLmNvbnN0cHJvcC43KzB4MWUvMHgyMzANCj4gICA/IHJlY29yZF9wcmludF90ZXh0LmNvbGQu
NDArMHgxMS8weDExDQo+ICAgPyBfcmF3X3NwaW5fdHJ5bG9ja19iaCsweDEyMC8weDEyMA0KPiAg
ID8gYmxrX3Rocm90bF9iaW8rMHgyMjUvMHgzMDUwDQo+ICAgPyBiaW9fZW5kaW8rMHg0NzcvMHg1
MDANCj4gICA/IGJpb19lbmRpbysweDQ3Ny8weDUwMA0KPiAgIGthc2FuX3JlcG9ydC5jb2xkLjkr
MHgzNy8weDdjDQo+ICAgPyBiaW9fZW5kaW8rMHg0NzcvMHg1MDANCj4gICBiaW9fZW5kaW8rMHg0
NzcvMHg1MDANCj4gICBudm1lX25zX2hlYWRfc3VibWl0X2JpbysweDk1MC8weDExMzAgW252bWVf
Y29yZV0NCj4gICA/IG52bWVfZmluZF9wYXRoKzB4N2YwLzB4N2YwIFtudm1lX2NvcmVdDQo+ICAg
PyBfX2thc2FuX3NsYWJfZnJlZSsweDExYS8weDE1MA0KPiAgID8gYmlvX2VuZGlvKzB4MjEzLzB4
NTAwDQo+ICAgc3VibWl0X2Jpb19ub2FjY3QrMHgyYTQvMHhkMTANCj4gICA/IF9kZXZfaW5mbysw
eGNkLzB4ZmYNCj4gICA/IF9kZXZfbm90aWNlKzB4ZmYvMHhmZg0KPiAgID8gYmxrX3F1ZXVlX2Vu
dGVyKzB4NmMwLzB4NmMwDQo+ICAgPyBfcmF3X3NwaW5fbG9ja19pcnErMHg4MS8weGQ1DQo+ICAg
PyBfcmF3X3NwaW5fbG9jaysweGQwLzB4ZDANCj4gICBudm1lX3JlcXVldWVfd29yaysweDE0NC8w
eDE4YyBbbnZtZV9jb3JlXQ0KPiAgIHByb2Nlc3Nfb25lX3dvcmsrMHg4NzgvMHgxM2UwDQo+ICAg
d29ya2VyX3RocmVhZCsweDg3LzB4ZjcwDQo+ICAgPyBfX2t0aHJlYWRfcGFya21lKzB4OGYvMHgx
MDANCj4gICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgxM2UwLzB4MTNlMA0KPiAgIGt0aHJlYWQrMHgz
MGYvMHgzZDANCj4gICA/IGt0aHJlYWRfcGFya21lKzB4ODAvMHg4MA0KPiAgIHJldF9mcm9tX2Zv
cmsrMHgxZi8weDMwDQo+IA0KPiBBbGxvY2F0ZWQgYnkgdGFzayA1MjoNCj4gICBrYXNhbl9zYXZl
X3N0YWNrKzB4MTkvMHg0MA0KPiAgIF9fa2FzYW5fa21hbGxvYy5jb25zdHByb3AuMTErMHhjOC8w
eGQwDQo+ICAgX19hbGxvY19kaXNrX25vZGUrMHg1Yy8weDMyMA0KPiAgIG52bWVfYWxsb2NfbnMr
MHg2ZTkvMHgxNTIwIFtudm1lX2NvcmVdDQo+ICAgbnZtZV92YWxpZGF0ZV9vcl9hbGxvY19ucysw
eDE3Yy8weDM3MCBbbnZtZV9jb3JlXQ0KPiAgIG52bWVfc2Nhbl93b3JrKzB4MmQ0LzB4NGQwIFtu
dm1lX2NvcmVdDQo+ICAgcHJvY2Vzc19vbmVfd29yaysweDg3OC8weDEzZTANCj4gICB3b3JrZXJf
dGhyZWFkKzB4ODcvMHhmNzANCj4gICBrdGhyZWFkKzB4MzBmLzB4M2QwDQo+ICAgcmV0X2Zyb21f
Zm9yaysweDFmLzB4MzANCj4gDQo+IEZyZWVkIGJ5IHRhc2sgNTQ6DQo+ICAga2FzYW5fc2F2ZV9z
dGFjaysweDE5LzB4NDANCj4gICBrYXNhbl9zZXRfdHJhY2srMHgxYy8weDMwDQo+ICAga2FzYW5f
c2V0X2ZyZWVfaW5mbysweDFiLzB4MzANCj4gICBfX2thc2FuX3NsYWJfZnJlZSsweDEwOC8weDE1
MA0KPiAgIGtmcmVlKzB4YTcvMHgzMDANCj4gICBkZXZpY2VfcmVsZWFzZSsweDk4LzB4MjEwDQo+
ICAga29iamVjdF9yZWxlYXNlKzB4MTA5LzB4M2EwDQo+ICAgbnZtZV9mcmVlX25zKzB4MTVlLzB4
MWY3IFtudm1lX2NvcmVdDQo+ICAgbnZtZV9yZW1vdmVfbmFtZXNwYWNlcysweDIyZi8weDM5MCBb
bnZtZV9jb3JlXQ0KPiAgIG52bWVfZG9fZGVsZXRlX2N0cmwrMHhhYy8weDEwNiBbbnZtZV9jb3Jl
XQ0KPiAgIHByb2Nlc3Nfb25lX3dvcmsrMHg4NzgvMHgxM2UwDQo+ICAgd29ya2VyX3RocmVhZCsw
eDg3LzB4ZjcwDQo+ICAga3RocmVhZCsweDMwZi8weDNkMA0KPiAgIHJldF9mcm9tX2ZvcmsrMHgx
Zi8weDMwDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMZWkgWWluIDx5aW5sZWkyQGxlbm92by5jb20+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDExICsrKysrKysrKystDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9kcml2ZXJzL252bWUvaG9z
dC9udm1lLmggaW5kZXggDQo+IGMzZTRkOWI2ZjljMC4uYjQ0MWM1Y2U0MTU3IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3Qv
bnZtZS5oDQo+IEBAIC03NDksOCArNzQ5LDE3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3Ry
YWNlX2Jpb19jb21wbGV0ZShzdHJ1Y3QgcmVxdWVzdCAqcmVxLA0KPiAgIHsNCj4gICAJc3RydWN0
IG52bWVfbnMgKm5zID0gcmVxLT5xLT5xdWV1ZWRhdGE7DQo+ICAgDQo+IC0JaWYgKChyZXEtPmNt
ZF9mbGFncyAmIFJFUV9OVk1FX01QQVRIKSAmJiByZXEtPmJpbykNCj4gKwlpZiAoKHJlcS0+Y21k
X2ZsYWdzICYgUkVRX05WTUVfTVBBVEgpICYmIHJlcS0+YmlvKSB7DQo+ICAgCQl0cmFjZV9ibG9j
a19iaW9fY29tcGxldGUobnMtPmhlYWQtPmRpc2stPnF1ZXVlLCByZXEtPmJpbyk7DQo+ICsNCj4g
KwkJLyogUG9pbnQgYmlvLT5iaV9kaXNrIHRvIGhlYWQgZGlzay4NCj4gKwkJICogVGhpcyBiaW8g
bWF5YmUgYXMgb3RoZXIgYmlvJ3MgcGFyZW50IGluIGJpbyBjaGFpbi4gSWYgdGhpcyBiaV9kaXNr
DQo+ICsJCSAqIGlzIGtmcmVlZCBieSBudm1lX2ZyZWVfbnMsIG90aGVyIGJpbyBtYXkgZ2V0IHRo
aXMgYmlvIGJ5IF9fYmlvX2NoYWluX2VuZGlvDQo+ICsJCSAqIGluIGJpb19lbmRpbywgYW5kIGFj
Y2VzcyB0aGlzIGJpX2Rpc2suIFRoaXMgd2lsbCB0cmlnZ2VyIGhlYXAtdXNlLWFmdGVyLWZyZWUN
Cj4gKwkJICogb3IgbnVsbCBwb2ludGVyIG9vcHMuDQo+ICsJCSAqLw0KPiArCQlyZXEtPmJpby0+
YmlfZGlzayA9IG5zLT5oZWFkLT5kaXNrOw0KPiArCX0NCg0KVGhpcyBpcyBhYnNvbHV0ZWx5IHRo
ZSB3cm9uZyBwbGFjZSB0byBkbyB0aGlzLiBUaGlzIGlzIGEgdHJhY2luZyBmdW5jdGlvbiwgaXQg
c2hvdWxkIG5vdCBoYXZlIGFueSBvdGhlciBsb2dpYy4NCg0KV2hhdCB0cmVlIGlzIHRoaXMgYWdh
aW5zdCBhbnl3YXlzPyBUaGVyZSBpcyBubyBiaV9kaXNrIGluIHN0cnVjdCBiaW8gYW55bW9yZS4N
Cg==
