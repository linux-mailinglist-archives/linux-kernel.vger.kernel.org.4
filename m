Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5E6CBE05
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjC1LrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjC1Lq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:46:58 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493815FF7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:46:53 -0700 (PDT)
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S9Xn1M028027;
        Tue, 28 Mar 2023 11:46:35 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3pkq299u60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 11:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw9PFsM7vQQEwen/WkQxITSoW6pjNMrDAtp6taiFJhodiAyIsvMG0A0I43245SltYDI2jU8o4VmVjanxBhcdxvHBO4Qy2CEvCPvZ86vBfcTmy40sQUQRyivjYWt6/bIRFkULCUosmK4VnID0Oqs+ocfJndJ4cpXh1UNagt4EXnopqlej40h/V2xRPq1fQPG7vOPHR1d+zlcg7QulrS28nDvU3W/JggAdw/xUN2X2as1Lq5JWVv6PfgVqo5F0OeEYw4+1zX6K7dXS39bbMnmVdhQUopfsKXoBFDDcwBZlLv0EFl29dMwgbe5fBOunOdXncyhk0hPitNwphA24VlAkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qKmWnoj5vjmFJbWqFY4zt+zKe2uqHMERXn07Z1eAvs=;
 b=PV9KRydVahk+ZsVlWkMEm5+wnDVDq3Hf3y9FGIwX9AwLpJO/1uVs/BNrHB8RSPIfdUmWiM67LL839vOlvbJYZUFhTQZWboptr/t3oDYCD44LskNu65uD+jhWjCRNln33DB6VJ93vBOJMqfEd2Q5W4lb/69ku7zpOQqbjIJYA0jb7hdUpT4WXgJYpX+8JczyC4/mO69mT88dRzIMFGCSxiNfWdxbsJDmFmrOSYvOx03/PSSMWNo/yfcQUt6Y+yuDRMWHmY7+qSPIcsTMz4BB5jJH7Zpq9K7qESpJ6CyR6KZOpzDCX4phbaSoEXBnYuF46SfZBMuCX4hu+dA7/EA5BWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qKmWnoj5vjmFJbWqFY4zt+zKe2uqHMERXn07Z1eAvs=;
 b=QTtmsA4kcdGc3urpb2LV/nbd8iAxJgoJF5ALL9PbzNDz1SUFPasOJWJLas7q/7xgTuGPPTAqiv0J8XuVBLb5qEq5LUaiOS7Z+pP3aCfJV4r36JjTcRCZR+C/+jCjGgrOq4Te/OgsB8Zi+dN+K1QkSPGfaau5CYbqtbHJ7KK/U/mvJikEqR86MBz/fAJj3tDnJ+G8KChKoEYo1GDuQ/Oi5jTLGy7IrcuiZE3EAZSzRnn9KHyDKlwHFdVNrvwelQRCobh3B6Rz+10DhKcX52N7LX/8vOArMIBux/37p77gkIvq2Y6VleiLy3q+u0qdBU9uC4ulL6mF/00YiHyfZyZG7w==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PAVPR03MB10101.eurprd03.prod.outlook.com (2603:10a6:102:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 11:46:32 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::bdd:a497:66a0:a342%5]) with mapi id 15.20.6222.030; Tue, 28 Mar 2023
 11:46:32 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Dan Carpenter <error27@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen/pciback: don't call pcistub_device_put() under lock
Thread-Topic: [PATCH] xen/pciback: don't call pcistub_device_put() under lock
Thread-Index: AQHZYVG3Th/ejZHSZUelfLFc3pO1U68QEzcA
Date:   Tue, 28 Mar 2023 11:46:32 +0000
Message-ID: <7e50b6ec-2b84-f5d9-0b5d-bf6e5e83cc25@epam.com>
References: <20230328084549.20695-1-jgross@suse.com>
In-Reply-To: <20230328084549.20695-1-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PAVPR03MB10101:EE_
x-ms-office365-filtering-correlation-id: 6d1a3875-2863-4f3f-247b-08db2f821383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kDv9O8zOVxeLcBS8Pp87FYh4zIxwxxkZsCUzNbRVvPbFVhVFMeyzh7UgGHqBgPJH+1hX4VeKErfkwgXRU/hAhmx5+0tKdOp4tZO9tV8YtUXvVCS2axVKwmCnHLIFbij/xvXQLN8amqk1fnSgHdp/butjDerVolg8a2iUIhu/XhBUyr2AqGZ2B+IU7ft9KdBnTRc26+GKLCoNPmVQ2MYZ0B7Aamdn/D9DxuPywQg4Gc3u4BdAWGU6WAbcDZgBFj6kK5lj9NB36QKhoDbwSI4LyqL26UW5WU0pFk0K7u2hHtY7v91WXrZBu8bDsEB+GvFpYwISi7gOmJfdl4OCHcgyhXQdu1j8grs8Zxxv/PbtZSDc0uz7odz33tPf0XADq0IBaMYK5kY+Fi6pbCQMP91bqIUH8HT3CiT9bwiwXP2cTsHccPwMfFrDSeuhrZgbEea4Gcg5NTrn6/yy9APDlWA6bM9ROVYCn+WOm2teQve38UI8iipqD9yc1e7e4Dj64Kg4EVtfylBclL7gMPyon8DNSJGKI17bQAGkIRoZScozHYgvg+ERQOvZF08KxOB+w8SvvLbidPig4yfvzsjFFYeRnmhKe/3fl+ppEMg5cb3+hECKFaik68SVmzLliHJrQXsrEVXGpIKyFii1khaEoo8Sg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(122000001)(5660300002)(8936002)(38100700002)(316002)(54906003)(41300700001)(66946007)(86362001)(6916009)(4326008)(66446008)(64756008)(8676002)(66556008)(66476007)(91956017)(76116006)(71200400001)(478600001)(2906002)(83380400001)(31686004)(6486002)(966005)(38070700005)(2616005)(31696002)(6512007)(6506007)(26005)(186003)(53546011)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1VVVGNJWC9WLy9kWnkwTXRXdWZRM0RrMGdrZDJXYjFPZlYwdEsrVGtjWE8x?=
 =?utf-8?B?NVUyRFl5M3ZVdkEwWmRrNUxQdHR6aVBzK2FqUDR3YTZ1ZzhweDVycnlqd0RH?=
 =?utf-8?B?b015dG52NDhJelFWaDB0aXhLV1lTYmFocFRZN1Y2UnBqdEw5N2FFVThMRG5m?=
 =?utf-8?B?UG5jcTFLbkVRZ2JrZU5SL1NkaUFSdHFrYy9aanhpYnVUS3ZkL2lMWjhYQlVp?=
 =?utf-8?B?RUkxR2lGREhwb2ZMUmJIcjlETW54QjcxL0tQdjNKR2ZRUUkzdGVsSkZUTmtO?=
 =?utf-8?B?a3JXNGQ2dTRUQUc2TU1rYmk1cU1ZcXhuK3dOa1VIc2V5U1ovVERpTW1pVzFu?=
 =?utf-8?B?c3hoRVk5MnFUWUVQQ1NrbTF6UW5xSlRZVjNZajQrOWxqS01vVytndXcwTE9O?=
 =?utf-8?B?UStXeEtOMW16SnJGK3JwYUNzOWhxQkVSZmZKSFk1L29iS1VEZlFzbzFmMFdq?=
 =?utf-8?B?UFprelkvdEtOVFQvd3hCVnROYy9aUEMwZjNHT3psWWFNTG14bzdTaVF0c0JB?=
 =?utf-8?B?ZlpCdi90WGM4aTdvblAxTGU4MHgyT0NWYU1qSDk2ZlM0L2xGVVpRcnJvSndZ?=
 =?utf-8?B?NTYwYTFkSG9haFEwelM0US9ZVEtuYTVhOGNtd21oVEI0enJmbGhsUmZtcE9u?=
 =?utf-8?B?bW9Ncm5Bekp0dDlXcldjNzZXczV4OERrMEN6RXNGWjFGeVp4NXFXVDFaeTBR?=
 =?utf-8?B?ckRoM0J2NkdFTXJoVHVwRmR0NVIzN1dTbWZuQWlneW5ZeXNUUGpEMjhNY3BU?=
 =?utf-8?B?SGxpclVmK0ErMWdONjd0ZFFqVmFQZ2s3aC9WOGcrcERkeEY4VkdlOGVvWUlV?=
 =?utf-8?B?R2oxVU4vSUlwZDdTMzBIUFBtdENtNmZMekdmRkhSRFROZEF3SzgwNC8vNnMx?=
 =?utf-8?B?WG1BQlkwZTUvL0ZKaFdIdndBUCtYSkxocnhZZ2ZJV3JEZ2lpNnJkNjliU2Ri?=
 =?utf-8?B?UUVMUng3MGo3YUI0MWNPRlZRM0dZTjdubGxuV0xqZE9jcFhLUHlzbHhtWnYx?=
 =?utf-8?B?UktFMXFhRnhTbDN4Tm5SUW9udER6N2luOGdYekFRTG5leVBWa3QwQ0NmU2pU?=
 =?utf-8?B?cVMzcThSK1p2aFlMZEhNNU42MnVweU1nUjBhY2QrRHRLMzM5elBUa0xlaWpr?=
 =?utf-8?B?TVVLaWsvNEY2dkJqcmhlaUVzNEpLQnM3OVorOG1jTnFCdnM4aXZ6UFU1cG1m?=
 =?utf-8?B?dzUraVdpdVNzbXJjdnBwcHc2RUlrNVRlRGxDRVBwL0pXVHlmRmFvaWRoSUFC?=
 =?utf-8?B?OEhzeXBycHhOV2JDZmVnWWN5T0YwTG5Oc2tDaEQwbHoxYk5hRkFNSHBuak1t?=
 =?utf-8?B?YzBpdTF4dExrd3U5Zi85K21lVlNHdUpVRlhIYTFDV3c3bVlJamlTNDVWNlNS?=
 =?utf-8?B?eHUyYjVJU1pzejArTU5JQmZrekF6T0RLQmtRQ0hLOG9FY1FpQ0dqb2N2S1Nk?=
 =?utf-8?B?bzF2NXRpRkE4Q1lIN1hUanNlT0ZiWktabjFIbWFMQWVvMTZRUWxHQm9Jc1FC?=
 =?utf-8?B?OXEwbXU4TEJmMDBUUkVSR2cyam5uTG9FUkZBY1JvNkVVZnI4ZXVKbUZsS3BS?=
 =?utf-8?B?MnUyczB4Tkg1OGJjVTRmUERkTDI5T1haVWQyZUNFOFRaTGVBNjFPaTBQbkc1?=
 =?utf-8?B?MjZRUmlRU21GRlZpMHNlNU9YYlBxWHE5WXVRVW16M0xWYzIySVhZalRyalhK?=
 =?utf-8?B?VGdMQlVoL2ZGL21jRHZzTXpMN21US1cwQjV0RXRpUzZ6bVcyN2cva3JZZ2Zr?=
 =?utf-8?B?U0kyT1ZOMVNSYVltNUlPalcydldjTGVrOXVSVVE3a3RpKzdTMXlURjFoNVN1?=
 =?utf-8?B?a0RiTS80cjJHWW1scFJyVzNIdXVYczBLd2lKcFJ6WkNTOTVlVFBTVnZQVDVx?=
 =?utf-8?B?aXY5TWdoNCtMcDlkWkZwT3J3aXFkdzRFcDBCYk40c2Q5ZktobE9seFFVR2ZS?=
 =?utf-8?B?Q2E4dGx4WmxJQVR2bmlETEJiUTk4bkFUV1pYMkxwWmJBdm5JRVkwdytsamU2?=
 =?utf-8?B?OE80bS8zbWZpOGRoeDMvaXduTklxRXpOUnkrM0NGTEF0aGZSMGhScitBazBV?=
 =?utf-8?B?cFlHaGRVTGN5Y2ZJVFNFbjBmaUhyNFpmVTUzQklZSVQ2QmVpY1N6bVRsd3VD?=
 =?utf-8?B?SHE4NnBYbS80SXBCazV4WmhqRW50YjhiNWpuQmVpR1kramtRSDk5WFBYOThu?=
 =?utf-8?Q?bqxKbK0JTsJ3YtywzmqIPxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1D6F9FCB86E354093817B58F58D320B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1a3875-2863-4f3f-247b-08db2f821383
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2023 11:46:32.2529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hv9GCN05PCBF9k+1yN4APl0UDRd57r6WE+ywdj5RfLupgxo64giDDH8o+0T2M9LWRe8jqHAR7A5gzrSn4iBd6bcdsJaOqU5d1ODpykmtRoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB10101
X-Proofpoint-GUID: woonEXiu3MeIReiKM2spzwpq7Z-XMHFR
X-Proofpoint-ORIG-GUID: woonEXiu3MeIReiKM2spzwpq7Z-XMHFR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=742 spamscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280094
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDI4LjAzLjIzIDExOjQ1LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQpIZWxsbyBKdWVy
Z2VuDQoNCj4gcGNpc3R1Yl9kZXZpY2VfcHV0KCkgc2hvdWxkbid0IGJlIGNhbGxlZCB1bmRlciBz
cGlubG9jaywgYXMgaXQgY2FuDQo+IHNsZWVwLg0KPiANCj4gRm9yIHRoaXMgcmVhc29uIHBjaXN0
dWJfZGV2aWNlX2dldF9wY2lfZGV2KCkgbmVlZHMgdG8gYmUgbW9kaWZpZWQ6DQo+IGluc3RlYWQg
b2YgYWx3YXlzIGNhbGxpbmcgcGNpc3R1Yl9kZXZpY2VfZ2V0KCkganVzdCBkbyB0aGUgY2FsbCBv
Zg0KPiBwY2lzdHViX2RldmljZV9nZXQoKSBvbmx5IGlmIGl0IGlzIHJlYWxseSBuZWVkZWQuIFRo
aXMgcmVtb3ZlcyB0aGUNCj4gbmVlZCB0byBjYWxsIHBjaXN0dWJfZGV2aWNlX3B1dCgpLg0KPiAN
Cj4gUmVwb3J0ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPg0KPiBMaW5r
OiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC9ZKkpVSWw2NFVEbWRrYm9oQGthZGFtL19fO0t3ISFHRl8yOWRiY1FJVUJQQSF3TzRIUjFqQ3JE
TU9mQjFJaDJxRVpzMmpucWNpZVpVWm5jNmNQd2g3VGE4aGlMUkt3UzFHcy0xdG1RUC1OdUVZb3o5
TGhZV0k4YUZhekl3SWE4TGgkIFtsb3JlWy5da2VybmVsWy5db3JnXQ0KPiBTaWduZWQtb2ZmLWJ5
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IE9sZWtz
YW5kciBUeXNoY2hlbmtvIDxvbGVrc2FuZHJfdHlzaGNoZW5rb0BlcGFtLmNvbT4NCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jIHwgNiArKy0tLS0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMgYi9kcml2ZXJzL3hl
bi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+IGluZGV4IGJiYTUyNzYyMDUwNy4uZTM0YjYyM2U0
YjQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+
ICsrKyBiL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMNCj4gQEAgLTE5NCw4ICsx
OTQsNiBAQCBzdGF0aWMgc3RydWN0IHBjaV9kZXYgKnBjaXN0dWJfZGV2aWNlX2dldF9wY2lfZGV2
KHN0cnVjdCB4ZW5fcGNpYmtfZGV2aWNlICpwZGV2LA0KPiAgIAlzdHJ1Y3QgcGNpX2RldiAqcGNp
X2RldiA9IE5VTEw7DQo+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgDQo+IC0JcGNpc3R1
Yl9kZXZpY2VfZ2V0KHBzZGV2KTsNCj4gLQ0KPiAgIAlzcGluX2xvY2tfaXJxc2F2ZSgmcHNkZXYt
PmxvY2ssIGZsYWdzKTsNCj4gICAJaWYgKCFwc2Rldi0+cGRldikgew0KPiAgIAkJcHNkZXYtPnBk
ZXYgPSBwZGV2Ow0KPiBAQCAtMjAzLDggKzIwMSw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGNpX2RldiAq
cGNpc3R1Yl9kZXZpY2VfZ2V0X3BjaV9kZXYoc3RydWN0IHhlbl9wY2lia19kZXZpY2UgKnBkZXYs
DQo+ICAgCX0NCj4gICAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHNkZXYtPmxvY2ssIGZsYWdz
KTsNCj4gICANCj4gLQlpZiAoIXBjaV9kZXYpDQo+IC0JCXBjaXN0dWJfZGV2aWNlX3B1dChwc2Rl
dik7DQo+ICsJaWYgKHBjaV9kZXYpDQo+ICsJCXBjaXN0dWJfZGV2aWNlX2dldChwc2Rldik7DQo+
ICAgDQo+ICAgCXJldHVybiBwY2lfZGV2Ow0KPiAgIH0=
