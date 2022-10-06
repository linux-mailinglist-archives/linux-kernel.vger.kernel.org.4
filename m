Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00095F7000
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiJFVNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJFVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:13:36 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982FDB14C1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:13:35 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296KQObi028393;
        Thu, 6 Oct 2022 21:13:24 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3k20nb1h54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 21:13:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jokl+Lub3YypAa8pyocSibZ0aqychExVx+/9yxOX+QyDbkbwhPdEsjGNAXKkehQRmBOKEbUbvcHCKX5yAZtC8I/ISISay81ng9qBRD37dlMp3CE/id6DFYZ4ixnqc/ghnVzJTqVy+K98YEbxTvRKp9VV2Jbab7xjWMGnpd3szTPBO7JgdrnWQ+ppCKa9AxZlgG7pukSugFneGWIGUNhmwNkg09lmLFkXPoWl9TkR5rmEws3KLlAqpxmUsHIKZTEBg0gzywddP3k0WfL4fwXPbXfECrJhh3YgpnRiD0HnoE4S9us7UEoA72aoPGg0DyAWTBxFFToGSVlYsfUcch2Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOAYTiF6yVTllsbBaDjAWpmZSozioT+tvv9trCPiaNY=;
 b=WBEXI93BX1kJYcZ4sult3Aw9S9H+N+xewqK5sNvfsZ66f+h3Fx6sDbaUpN6VhHg7yZYo7Sz7KVznYa86JvTn1aLbPYmic2XL6kpOnfaIh17htWgTdzyQCGMYFOGSX/LcpQ1atDXVXJfHW9aQBefc/OUlfroORAZocTgYojWE/d3Duv2s+aT6VKS/YLuPifXm480+TvkN3pyfx9TY+cCvbOX8Z1Dja2psTNm9KUwIvbkWtPzNS+flPJmmbUxx3F8z0McsPfEoT2Qpg5j8/uDe6qstYobsVDVaj9RDz53gpKhUa5CQt424cUGj4tF9sCIIrdOg6CXTlr5D4Z1PQEpXZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOAYTiF6yVTllsbBaDjAWpmZSozioT+tvv9trCPiaNY=;
 b=VQpt6SFFWFXsQhB1vKEt+ojCoIcHdaZXPgZOfJGnlaJrDXtiJYcn7E7/GBI6vgHFIqo7cx+8qE1uQZJ6Q1Z3tutPMpkDOldl7tMolhmXQ+TBGAyCxFApN/eX1pEqO0b+fi0V2CyfCa8ziig6gdNDIYXmTdQwCjBoiin/Bn/SevjZXyU1ibKGdLVAqJw1b9gSXv/cUHZfv4qcRixpTnKqYSAyMiE8I3PsHUuKcPFTRg/UhFlVleMpdOyexQz3pbkBiZVow8k3a+vn1NnKfBVW0aQZiWmgC0MfxmZFaa8w32GeZOQjaYNGDhb9sLeVB8wDHTyOrsD6JW8cnXo1dipZgw==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS4PR03MB8674.eurprd03.prod.outlook.com (2603:10a6:20b:58a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Thu, 6 Oct
 2022 21:13:20 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::93be:22b1:654c:e4bc%5]) with mapi id 15.20.5676.038; Thu, 6 Oct 2022
 21:13:20 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Xenia Ragiadakou <burzalodowa@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: Re: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Thread-Topic: [PATCH] xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen
 counterparts
Thread-Index: AQHY2Xx9ME9woenUJk6IqJF2QACToq4Bp86AgAA2I4A=
Date:   Thu, 6 Oct 2022 21:13:20 +0000
Message-ID: <b3b8047e-b4a5-1e75-2a55-a7beecf8ca7d@epam.com>
References: <20221006120912.1948459-1-olekstysh@gmail.com>
 <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
In-Reply-To: <96a16b32-0950-b538-65e5-9955ed8cc529@gmail.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS4PR03MB8674:EE_
x-ms-office365-filtering-correlation-id: 42d88c83-0efd-4e76-afbb-08daa7df985e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9mQ7CMP7pimJTHID0igefuMjXr2K76yCvNS/9fk4vYPLhUY5mBehIdI6TlErWiAotNiAbMYBbem+vXx/yrdjbvRp5YPu093co3+lJZGGuMjVS8UAWKpBFf6es1AIILf2d2ssfITvmW7dNq5+1bMlq1cz7rb9ZZrgeu+w4AweXpk+NYGDeCfxP72tZ3hqx1fiXlPuiHMgq5p3BCPqBoR+xguTiJaktstmxMLfMkBIyf4kh7xWXSj8cO24CmcEh/rhE5fcgDSrCkL9oU/dpSErsA/3TvhDTJKH4Dh95D0k91ICbfDdOxe3vkl1eZcXh1vSdqVBVLhvs56rvdW67csL0wZjhuyH/EFUzyAa0g4GQpsESbT3JVRKtDLa4WihCGpvZBcYVOkU9c0SQ7J0QmWNvzhKjAHcEIwoY43zrUJXARGXkT+hr55LA1ogYQ0hCjsYEPFI+a0o89zIn2x5hJVroPD3GdVD0+u8AeM9ISiUtqmT47TW8N9flGjOFHTSA870Le8mSv1QB37w4Wus1VclCN0pFFzf45EyBBKmh/b1Edft9hVIXcUrrrzPVnGIbb3BIqYkYTUtYE9V9rDE/Ur+92ewp/rIQsYrGwu4Rj/oP/hd/EEPzD4qyOqIbut0C+7NywjORHnDKTDAVzt8RFIYhBp0EO2868uvZEEqSgQ9BDV37ZC6U7lnd2Ob83gJZeOOGCD1HFacNjfUu7+n7ZWsqgcorDMcHfhSfsCm7JWnXjpUbfK6g+71ub4vhx2VA6xqbuQDkUrIx9JKyUpvovR4ydIAFQ7L10IjE9owqe9sKrzvpJI9O9WUswkRhQ3CRbNv0X530d+OiNWIvzEWWidKZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(41300700001)(38070700005)(53546011)(122000001)(5660300002)(8936002)(966005)(6486002)(186003)(478600001)(2616005)(31696002)(86362001)(26005)(55236004)(6506007)(6512007)(66476007)(71200400001)(76116006)(64756008)(4326008)(316002)(36756003)(8676002)(54906003)(66446008)(110136005)(83380400001)(66946007)(91956017)(31686004)(66556008)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1RML0QxUko1S0xyZzJsNWU1clFEM2JuMUswYng0V09Xc2Z4RUZ0RWJWUFR6?=
 =?utf-8?B?ZlBQTEozOHJDS1pBQk1naW9US2p5V1l4WHl6eVZSTTlWVERRejJxa3hjT3JO?=
 =?utf-8?B?RytpVGE0TE9HdENwRzJvWTQ4TS9PS1lJV3RFeWdqZ2xIdzVDVjlkZmNaTjB1?=
 =?utf-8?B?dXU3UDN5Z2dadDFqVWxZMVFkVmxPeE9hNzhkdDVmOEJHNHVyOWowb0ViMW9O?=
 =?utf-8?B?N3BUdmZqNWE0bnYwWXlsUjlibFZtRTZKbm5Qd3VQaEtvV2ZwWkI4Wm9QcWRK?=
 =?utf-8?B?MExCN2JZdXFhYkc1bW9jbER3ZnllZHVOVTVobGJ2NjlWZFNpUzZqd2I1c24x?=
 =?utf-8?B?WlM5MW1Wb2UrNWJlWVdLSjBJUVU3RFI3MkpZSFV1eXVEbGZIdCtzNHpOa1oy?=
 =?utf-8?B?OXkrTEh6MVZENVdlSFNzWUlPaWxXK2gzSjd4TFFHcUdoVlJ0cUdwNENNQW5T?=
 =?utf-8?B?U0llbGVrbWVWTzAyR1QyT3llaldoQkpJdDFjMzQvdWkrQVNiQS9lWC9lc0JS?=
 =?utf-8?B?QnVQd0dTaER4QU0vQzZ0cmQyNzFaNG13MTdiS3lSVmtjT3dla1BEZHBpdks1?=
 =?utf-8?B?dVFueWFFeW1RekNGN2dKVEN4VCtYSlFKUVYzQVRac1VsY1J3L2xycWNpSFVM?=
 =?utf-8?B?dFc2NHI4VzlrT0lIcEVqSzg4TEFlUHFvVDdhVUcxZ0hCN2laRTBQRnd3LzY0?=
 =?utf-8?B?SUVNdEd0MlhBT3ZSV21YUzBISjR4cTkybEo1VXA3MjFqeXcwckhpUGUxejFo?=
 =?utf-8?B?NWNweWZUUXhDTGdPbkRnYWMwRWNtMjZrSGpFSUVUTUgvWkdhVkRDdGg0MTl2?=
 =?utf-8?B?dFVYREJ6bXpHdVBOVHBvU0xpQ1pxSGp3SFhaaXlJVGc1aHRJblJqYm4yVUJL?=
 =?utf-8?B?a2l4eHZIRnpibWNPOTVDVTBqZnU3WDhDaWFrOUxsd1FSY0NIN3g4UWFoMHBj?=
 =?utf-8?B?QzdEcDAzUk82RUw2aWh4OSsyb1lXQmNjNXNzQXg2NEg5N2Y4VEdZY1ZXWlRk?=
 =?utf-8?B?SXpIQ1NKN3FoeEZsUU1MK0xteTljV0x5bzNYZ0pFQitlWXJ0U2hFeWJ4eWNU?=
 =?utf-8?B?Nm9iSGJ5ZFhTU01QUm0vbmg2K0g1eUhVZktDL0EzTkc0aFlSUDZ5TllteGRy?=
 =?utf-8?B?VDl2ZkVveVVvYnpSUUNqVjI5bkN2TWErMTU1RVFwNE9tQUJDS2prY1IyQTBN?=
 =?utf-8?B?SG5QTDRKTFoyMmxmZWNmQ0ZRajRTZlVZTktieVQ3MDZxOEtaa3RyWEtkMVdq?=
 =?utf-8?B?QmJ2ZjRBSEU1Uzh3YVNaMUFPR0NUdldPYlNWMEg1WDh2Sy9MNHRiVE52aEVu?=
 =?utf-8?B?VHU3SjcyZ2VQMGY0QjhTbEpMR3c4MlRoK1Y1YTN3N1RJR0ppSTNST0Roekpq?=
 =?utf-8?B?SGVHT1RuUlF3K05melpMZ0o0TjFKTFZXZUxTUzE5aDdpOVpzeWR5SmZVaW1I?=
 =?utf-8?B?UnpUKzJGUHVnRUoxdyt2YVgweWxJOXpjOHM0QzZ6dFBESFpjVUJsbjRMcGND?=
 =?utf-8?B?M3Aya1ltdGt1SWRTbkV5cWZFc0p5QlhIQmZacmZhZTZWVmlncFIvRGdJbUxI?=
 =?utf-8?B?T29kaSszMXJER2VIZWIxMGNmZ3JOVmIzMUdWYjlZRStKMlRmM2FvY0IwaEYr?=
 =?utf-8?B?bDNwU0MvcHhvam93TnVIUURud29wRE9YNWd2dDZIZWJZamJ2bnA0RlNJQVJi?=
 =?utf-8?B?Y0JFN21BNW1MMldkcUVEM3V5OEQvQTI2Z1J6dUhNN3VGR1dVVSs1OHc5TmZk?=
 =?utf-8?B?a0JFQW5QWUNHRWx0N3VrR3lhNmpaZUJYdlBtQWhVSkZRTG9vdUpSRkg3Y0Er?=
 =?utf-8?B?aHJGeEVBazJuUmI4VnVPZlVvNkJOMXgwdWR1OURyN2d2V2FFZldBRGNPRXVT?=
 =?utf-8?B?V2lwSW5QRDFHdHc3QnJWbi8wL0dXMUtsNVdzaXAycDF2MWRwRGFpQ2pCZmh3?=
 =?utf-8?B?UWhwUTlFc1pTalFNTlROTmZuTEJEVFdIOGZPUGQ1ZWtkZVBMZzNXUU5vSzNS?=
 =?utf-8?B?YjdwS2xqMDdaY2dmZ3crVk8yZFV4azF4WVN0Z0tvTTZEaG9hbTZxc3lZQnBV?=
 =?utf-8?B?VW52WWtkcU02UjluYTVBeXR0RXpHbnNWT002Rkk5b0c4SXpaVllEUmFOWksr?=
 =?utf-8?B?U1UvRjNHZHZ0U09FK3JSVjdkV25oV0hoN1JDT21FQkF1ZWFjaTByT2cxZC95?=
 =?utf-8?Q?mivthaEjtnX1RYLxYcLym0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B352496786BFB4B9CE701AD68570EB3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d88c83-0efd-4e76-afbb-08daa7df985e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 21:13:20.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPy+OAxemuIyy9NAWSLwZMgXGgtv4X47BuTa9Tn/OWTkd04lAOiMbhSPZ5ha8Wol7UvnyK2dRd97XeGajjK2L8DMCbCjcrX0yCAqV48WKa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8674
X-Proofpoint-ORIG-GUID: DqQ1h4eFnyrVLurkTH7uQZMGnmdzatT8
X-Proofpoint-GUID: DqQ1h4eFnyrVLurkTH7uQZMGnmdzatT8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_04,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060126
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAwNi4xMC4yMiAyMDo1OSwgWGVuaWEgUmFnaWFkYWtvdSB3cm90ZToNCg0KSGVsbG8gWGVu
aWENCg0KPg0KPiBPbiAxMC82LzIyIDE1OjA5LCBPbGVrc2FuZHIgVHlzaGNoZW5rbyB3cm90ZToN
Cj4+IEZyb206IE9sZWtzYW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFt
LmNvbT4NCj4+DQo+PiBBbHRob3VnaCBYRU5fUEFHRV9TSVpFIGlzIGVxdWFsIHRvIFBBR0VfU0la
RSAoNEtCKSBmb3Igbm93LCBpdCB3b3VsZA0KPj4gYmUgbW9yZSBjb3JyZWN0IHRvIHVzZSBYZW4g
c3BlY2lmaWMgI2RlZmluZS1zIGFzIFhFTl9QQUdFX1NJWkUgY2FuDQo+PiBiZSBjaGFuZ2VkIGF0
IHNvbWUgcG9pbnQgaW4gdGhlIGZ1dHVyZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2Fu
ZHIgVHlzaGNoZW5rbyA8b2xla3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQo+PiAtLS0NCj4+
IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+PiBDYzogWGVuaWEgUmFnaWFk
YWtvdSA8YnVyemFsb2Rvd2FAZ21haWwuY29tPg0KPj4NCj4+IEFzIGl0IHdhcyBwcm9wb3NlZCBh
dDoNCj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9y
Zy94ZW4tZGV2ZWwvMjAyMjEwMDUxNzQ4MjMuMTgwMDc2MS0xLW9sZWtzdHlzaEBnbWFpbC5jb20v
X187ISFHRl8yOWRiY1FJVUJQQSF6SHQteFpfN3RaY19FTTZ6dmEyMUVfWWd3SWlFZWltRldmc0pJ
cFB3QXUtVEJjbnpRaFhIcWxLem1YbXdJY0k2dUl4X2FySE5aaWFaZUh0XzQyOF84cC1EeU1wZCQg
DQo+PiBbbG9yZVsuXWtlcm5lbFsuXW9yZ10NCj4+DQo+PiBTaG91bGQgZ28gaW4gb25seSBhZnRl
ciB0aGF0IHNlcmllcy4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5j
IHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94
ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+PiBpbmRl
eCBjNjZmNTZkMjQwMTMuLjUzOTJmZGMyNWRjYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVu
L2dyYW50LWRtYS1vcHMuYw0KPj4gKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jDQo+
PiBAQCAtMzEsMTIgKzMxLDEyIEBAIHN0YXRpYyBERUZJTkVfWEFSUkFZX0ZMQUdTKHhlbl9ncmFu
dF9kbWFfZGV2aWNlcywgDQo+PiBYQV9GTEFHU19MT0NLX0lSUSk7DQo+PiDCoCDCoCBzdGF0aWMg
aW5saW5lIGRtYV9hZGRyX3QgZ3JhbnRfdG9fZG1hKGdyYW50X3JlZl90IGdyYW50KQ0KPj4gwqAg
ew0KPj4gLcKgwqDCoCByZXR1cm4gWEVOX0dSQU5UX0RNQV9BRERSX09GRiB8ICgoZG1hX2FkZHJf
dClncmFudCA8PCBQQUdFX1NISUZUKTsNCj4+ICvCoMKgwqAgcmV0dXJuIFhFTl9HUkFOVF9ETUFf
QUREUl9PRkYgfCAoKGRtYV9hZGRyX3QpZ3JhbnQgPDwgDQo+PiBYRU5fUEFHRV9TSElGVCk7DQo+
PiDCoCB9DQo+DQo+IFdpdGggdGhpcyBjaGFuZ2UsIGNhbiB0aGUgb2Zmc2V0IGFkZGVkIHRvIHRo
ZSBkbWEgaGFuZGxlLCBnZW5lcmF0ZWQgYnkgDQo+IGdyYW50X3RvX2RtYSgpLCBiZSB0aGUgb2Zm
c2V0IGluIHRoZSBwYWdlPyBDb3VsZG4ndCBpdCBjb3JydXB0IHRoZSANCj4gZ3JhbnQgcmVmPw0K
DQoNCkdvb2QgcG9pbnQsIGluZGVlZCwgSSB0aGluayBpdCBjb3VsZCBjb3JydXB0IGlmIGd1ZXN0
IHVzZXMgYSBkaWZmZXJlbnQgDQp0aGFuIFhlbiBwYWdlIGdyYW51bGFyaXR5IChpLmUgNjRLQiku
DQoNCg0KPg0KPj4gwqAgwqAgc3RhdGljIGlubGluZSBncmFudF9yZWZfdCBkbWFfdG9fZ3JhbnQo
ZG1hX2FkZHJfdCBkbWEpDQo+PiDCoCB7DQo+PiAtwqDCoMKgIHJldHVybiAoZ3JhbnRfcmVmX3Qp
KChkbWEgJiB+WEVOX0dSQU5UX0RNQV9BRERSX09GRikgPj4gDQo+PiBQQUdFX1NISUZUKTsNCj4+
ICvCoMKgwqAgcmV0dXJuIChncmFudF9yZWZfdCkoKGRtYSAmIH5YRU5fR1JBTlRfRE1BX0FERFJf
T0ZGKSA+PiANCj4+IFhFTl9QQUdFX1NISUZUKTsNCj4+IMKgIH0NCj4+IMKgIMKgIHN0YXRpYyBz
dHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpmaW5kX3hlbl9ncmFudF9kbWFfZGF0YShzdHJ1Y3Qg
DQo+PiBkZXZpY2UgKmRldikNCj4+IEBAIC03OSw3ICs3OSw3IEBAIHN0YXRpYyB2b2lkICp4ZW5f
Z3JhbnRfZG1hX2FsbG9jKHN0cnVjdCBkZXZpY2UgDQo+PiAqZGV2LCBzaXplX3Qgc2l6ZSwNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGF0dHJz
KQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgeGVuX2dyYW50X2RtYV9kYXRhICpkYXRh
Ow0KPj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdlcyA9IFBGTl9VUChzaXplKTsNCj4+
ICvCoMKgwqAgdW5zaWduZWQgaW50IGksIG5fcGFnZXMgPSBYRU5fUEZOX1VQKHNpemUpOw0KPj4g
wqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBmbjsNCj4+IMKgwqDCoMKgwqAgZ3JhbnRfcmVmX3Qg
Z3JhbnQ7DQo+PiDCoMKgwqDCoMKgIHZvaWQgKnJldDsNCj4+IEBAIC05MSwxNCArOTEsMTQgQEAg
c3RhdGljIHZvaWQgKnhlbl9ncmFudF9kbWFfYWxsb2Moc3RydWN0IGRldmljZSANCj4+ICpkZXYs
IHNpemVfdCBzaXplLA0KPj4gwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoZGF0YS0+YnJva2VuKSkN
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsNCj4+IMKgIC3CoMKgwqAgcmV0ID0g
YWxsb2NfcGFnZXNfZXhhY3Qobl9wYWdlcyAqIFBBR0VfU0laRSwgZ2ZwKTsNCj4+ICvCoMKgwqAg
cmV0ID0gYWxsb2NfcGFnZXNfZXhhY3Qobl9wYWdlcyAqIFhFTl9QQUdFX1NJWkUsIGdmcCk7DQo+
PiDCoMKgwqDCoMKgIGlmICghcmV0KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxM
Ow0KPj4gwqAgwqDCoMKgwqDCoCBwZm4gPSB2aXJ0X3RvX3BmbihyZXQpOw0KPj4gwqAgwqDCoMKg
wqDCoCBpZiAoZ250dGFiX2FsbG9jX2dyYW50X3JlZmVyZW5jZV9zZXEobl9wYWdlcywgJmdyYW50
KSkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIGZyZWVfcGFnZXNfZXhhY3QocmV0LCBuX3BhZ2VzICog
UEFHRV9TSVpFKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBmcmVlX3BhZ2VzX2V4YWN0KHJldCwgbl9w
YWdlcyAqIFhFTl9QQUdFX1NJWkUpOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxM
Ow0KPj4gwqDCoMKgwqDCoCB9DQo+PiDCoCBAQCAtMTE2LDcgKzExNiw3IEBAIHN0YXRpYyB2b2lk
IHhlbl9ncmFudF9kbWFfZnJlZShzdHJ1Y3QgZGV2aWNlIA0KPj4gKmRldiwgc2l6ZV90IHNpemUs
IHZvaWQgKnZhZGRyLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBkbWFfYWRkcl90IGRtYV9oYW5kbGUsIHVuc2lnbmVkIGxvbmcgYXR0cnMpDQo+PiDCoCB7DQo+
PiDCoMKgwqDCoMKgIHN0cnVjdCB4ZW5fZ3JhbnRfZG1hX2RhdGEgKmRhdGE7DQo+PiAtwqDCoMKg
IHVuc2lnbmVkIGludCBpLCBuX3BhZ2VzID0gUEZOX1VQKHNpemUpOw0KPj4gK8KgwqDCoCB1bnNp
Z25lZCBpbnQgaSwgbl9wYWdlcyA9IFhFTl9QRk5fVVAoc2l6ZSk7DQo+PiDCoMKgwqDCoMKgIGdy
YW50X3JlZl90IGdyYW50Ow0KPj4gwqAgwqDCoMKgwqDCoCBkYXRhID0gZmluZF94ZW5fZ3JhbnRf
ZG1hX2RhdGEoZGV2KTsNCj4+IEBAIC0xMzgsNyArMTM4LDcgQEAgc3RhdGljIHZvaWQgeGVuX2dy
YW50X2RtYV9mcmVlKHN0cnVjdCBkZXZpY2UgDQo+PiAqZGV2LCBzaXplX3Qgc2l6ZSwgdm9pZCAq
dmFkZHIsDQo+PiDCoCDCoMKgwqDCoMKgIGdudHRhYl9mcmVlX2dyYW50X3JlZmVyZW5jZV9zZXEo
Z3JhbnQsIG5fcGFnZXMpOw0KPj4gwqAgLcKgwqDCoCBmcmVlX3BhZ2VzX2V4YWN0KHZhZGRyLCBu
X3BhZ2VzICogUEFHRV9TSVpFKTsNCj4+ICvCoMKgwqAgZnJlZV9wYWdlc19leGFjdCh2YWRkciwg
bl9wYWdlcyAqIFhFTl9QQUdFX1NJWkUpOw0KPj4gwqAgfQ0KPj4gwqAgwqAgc3RhdGljIHN0cnVj
dCBwYWdlICp4ZW5fZ3JhbnRfZG1hX2FsbG9jX3BhZ2VzKHN0cnVjdCBkZXZpY2UgKmRldiwgDQo+
PiBzaXplX3Qgc2l6ZSwNCj4+IEBAIC0xNjgsNyArMTY4LDcgQEAgc3RhdGljIGRtYV9hZGRyX3Qg
eGVuX2dyYW50X2RtYV9tYXBfcGFnZShzdHJ1Y3QgDQo+PiBkZXZpY2UgKmRldiwgc3RydWN0IHBh
Z2UgKnBhZ2UsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB1bnNpZ25lZCBsb25nIGF0dHJzKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgeGVu
X2dyYW50X2RtYV9kYXRhICpkYXRhOw0KPj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdl
cyA9IFBGTl9VUChvZmZzZXQgKyBzaXplKTsNCj4+ICvCoMKgwqAgdW5zaWduZWQgaW50IGksIG5f
cGFnZXMgPSBYRU5fUEZOX1VQKG9mZnNldCArIHNpemUpOw0KPg0KPiBUaGUgb2Zmc2V0LCBoZXJl
LCByZWZlcnMgdG8gdGhlIG9mZnNldCBpbiB0aGUgcGFnZSAuLi4NCj4NCj4+IMKgwqDCoMKgwqAg
Z3JhbnRfcmVmX3QgZ3JhbnQ7DQo+PiDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgZG1hX2hhbmRsZTsN
Cj4+IMKgIEBAIC0yMDAsOCArMjAwLDggQEAgc3RhdGljIHZvaWQgeGVuX2dyYW50X2RtYV91bm1h
cF9wYWdlKHN0cnVjdCANCj4+IGRldmljZSAqZGV2LCBkbWFfYWRkcl90IGRtYV9oYW5kbGUsDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIGF0dHJzKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgeGVuX2dyYW50X2RtYV9k
YXRhICpkYXRhOw0KPj4gLcKgwqDCoCB1bnNpZ25lZCBsb25nIG9mZnNldCA9IGRtYV9oYW5kbGUg
JiAoUEFHRV9TSVpFIC0gMSk7DQo+PiAtwqDCoMKgIHVuc2lnbmVkIGludCBpLCBuX3BhZ2VzID0g
UEZOX1VQKG9mZnNldCArIHNpemUpOw0KPj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIG9mZnNldCA9
IGRtYV9oYW5kbGUgJiB+WEVOX1BBR0VfTUFTSzsNCj4NCj4gLi4uIHdoaWxlLCBoZXJlLCBpdCBy
ZWZlcnMgdG8gdGhlIG9mZnNldCBpbiB0aGUgZ3JhbnQuDQo+IFNvLCB0aGUgY2FsY3VsYXRlZCBu
dW1iZXIgb2YgZ3JhbnRzIG1heSBkaWZmZXIuDQoNCkdvb2QgcG9pbnQsIEkgdGhpbmsgeW91IGFy
ZSByaWdodCwgc28gd2UgbmVlZCB0byBhZGRpdGlvbmFsbHkgdXNlIA0KeGVuX29mZnNldF9pbl9w
YWdlKCkgbWFjcm8gaW4geGVuX2dyYW50X2RtYV9tYXBfcGFnZSgpLA0KDQpzb21ldGhpbmcgbGlr
ZSB0aGF0IHRvIGJlIHNxdWFzaGVkIHdpdGggY3VycmVudCBwYXRjaDoNCg0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5jIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9w
cy5jDQppbmRleCA5ZDVlY2E2ZDYzOGEuLmJiOTg0ZGMwNWRlYiAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMveGVuL2dyYW50LWRtYS1vcHMuYw0KKysrIGIvZHJpdmVycy94ZW4vZ3JhbnQtZG1hLW9wcy5j
DQpAQCAtMTY5LDcgKzE2OSw3IEBAIHN0YXRpYyBkbWFfYWRkcl90IHhlbl9ncmFudF9kbWFfbWFw
X3BhZ2Uoc3RydWN0IA0KZGV2aWNlICpkZXYsIHN0cnVjdCBwYWdlICpwYWdlLA0KIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYXR0cnMpDQogwqB7DQogwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHhlbl9ncmFudF9kbWFfZGF0YSAqZGF0YTsNCi3CoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgaW50IGksIG5fcGFnZXMgPSBYRU5fUEZOX1VQKG9mZnNldCArIHNpemUpOw0KK8KgwqDCoMKg
wqDCoCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdlcyA9IFhFTl9QRk5fVVAoeGVuX29mZnNldF9pbl9w
YWdlKG9mZnNldCkgDQorIHNpemUpOw0KIMKgwqDCoMKgwqDCoMKgIGdyYW50X3JlZl90IGdyYW50
Ow0KIMKgwqDCoMKgwqDCoMKgIGRtYV9hZGRyX3QgZG1hX2hhbmRsZTsNCg0KQEAgLTE5MSw3ICsx
OTEsNyBAQCBzdGF0aWMgZG1hX2FkZHJfdCB4ZW5fZ3JhbnRfZG1hX21hcF9wYWdlKHN0cnVjdCAN
CmRldmljZSAqZGV2LCBzdHJ1Y3QgcGFnZSAqcGFnZSwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fcGFnZV90b19nZm4o
cGFnZSkgKyBpLCBkaXIgPT0gDQpETUFfVE9fREVWSUNFKTsNCiDCoMKgwqDCoMKgwqDCoCB9DQoN
Ci3CoMKgwqDCoMKgwqAgZG1hX2hhbmRsZSA9IGdyYW50X3RvX2RtYShncmFudCkgKyBvZmZzZXQ7
DQorwqDCoMKgwqDCoMKgIGRtYV9oYW5kbGUgPSBncmFudF90b19kbWEoZ3JhbnQpICsgeGVuX29m
ZnNldF9pbl9wYWdlKG9mZnNldCk7DQoNCiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZG1hX2hhbmRs
ZTsNCiDCoH0NCg0KRGlkIEkgZ2V0IHlvdXIgcG9pbnQgcmlnaHQ/DQoNCg0KPg0KPg0KPj4gK8Kg
wqDCoCB1bnNpZ25lZCBpbnQgaSwgbl9wYWdlcyA9IFhFTl9QRk5fVVAob2Zmc2V0ICsgc2l6ZSk7
DQo+PiDCoMKgwqDCoMKgIGdyYW50X3JlZl90IGdyYW50Ow0KPj4gwqAgwqDCoMKgwqDCoCBpZiAo
V0FSTl9PTihkaXIgPT0gRE1BX05PTkUpKQ0KPg0KDQpUaGFuayB5b3UuDQoNCg0KLS0gDQpSZWdh
cmRzLA0KDQpPbGVrc2FuZHIgVHlzaGNoZW5rbw0K
