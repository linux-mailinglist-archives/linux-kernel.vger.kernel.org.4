Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C476C6456
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCWKCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjCWKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:02:16 -0400
X-Greylist: delayed 3728 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Mar 2023 03:02:10 PDT
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FA33599;
        Thu, 23 Mar 2023 03:02:09 -0700 (PDT)
Received: from pps.filterd (m0115756.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N62MRE022097;
        Thu, 23 Mar 2023 04:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=AdPPJrbvSxMeGePH+qkEl6iE4R8dbNJMargPv4PP/AE=;
 b=1l0djxWMwguAL0nuOwp6HXZgUOv4qnwIvWBzqmbNZugz5gfWp39jYjobAwIsTGb/nvlz
 Vszmg8KsZp+QlKIIQ/6VBgffmyv+mAEiWmTgFcnNH+eg0K/KaZuMF3M38W5cfItkDUnL
 ATQX76Gm6L3faeHcROeeuq7IyIssoh8vmrEmrzj/umyt+0xaPlc9R4FKe3yRVnzp8rE+
 yxGz7byS74mexrFH3jvoDRFG8q8/G/DA9pD/04YMU4IhoRauW/hAOzsoARpKpFnB5mlR
 gndBwdLYc/g0aFlkkDZSatd3o/uTRJM5mgpbFoAM/kC0oQjS8qcWDjcQ4IUOmp66aOhp fA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3pfck065xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:59:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRs5VwhRhRjvHkOpDy2bpz8PMQmXkmVzO0GxhxTEnXyUa9K8aFsA9MuSaHwlKjGCyRbh/6jFfE/Oi79HUdVG2LPO9ivibwnctvPWcV1bYdWMP9Lc7blwd3Db0cl7hrDsdBRzTeh1nRJkaT5I763HBLkz4tfvfwJSURuee01hq1cZc5feh3SvMODDEW9btwdk7cxFVmKbpdTqa+pY5U8VBLr2LMn6no0WXcAuPlyarzAoFN0D6VKUTBvKWtbrZsVqC9dc2067/WrJOxS7vx7thUPG01fOWJsN9/5qujJdjivyYhNAL1AHsKJu9vdhtQo3EeyKzcfhDXNIWSDvMO92dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdPPJrbvSxMeGePH+qkEl6iE4R8dbNJMargPv4PP/AE=;
 b=hlUI9wTTMOXYZ3nYLmulvp7T1B7VN24H4UZAsKo2pOabb50rkWl1H19mT3iZqmELapheoKECMi2FeGrXZb1JCirc3q/qTMA4NdsFRiRoOFKHyt9WVa2Idpx+t6JsRGK8lh66V1QfPcHEQ+TZiNIAmJ8vad5NpDhXeef3iSMYVf6FH8HMkTNyWTnoYrwItkLVBS0PJsz15G2CsOd6OYqoZl8zgAsR46yvVS7uwDa547E8ukW36qNIVWmD9eysAmvYskBSfjF3M7OD6OUYpCbPm80RQOcK4+UopYtyFWzoKesV1nlu9qj/qrBDBUY6DgHyUQd9YRNDot9pNeqbxOHIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by DS0PR15MB6039.namprd15.prod.outlook.com (2603:10b6:8:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 08:59:43 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:59:43 +0000
From:   "Leonard, Niall" <Niall.Leonard@ncr.com>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        "linux@steffen.cc" <linux@steffen.cc>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
Subject: Re: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=NULL again
 in dup_task_struct
Thread-Topic: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=NULL
 again in dup_task_struct
Thread-Index: AQHZWwKU7AYdn8EL3kGBdr8btuge0K8DgwUAgASRkcE=
Date:   Thu, 23 Mar 2023 08:59:43 +0000
Message-ID: <MW5PR15MB52187150E6E98BB7DDBB7335FD879@MW5PR15MB5218.namprd15.prod.outlook.com>
References: <20230320080347.32434-1-linux@steffen.cc>
 <ZBg+3pGG9v+hQFYI@uudg.org>
In-Reply-To: <ZBg+3pGG9v+hQFYI@uudg.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=True;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2023-03-23T08:59:42.587Z;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=Confidential;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|DS0PR15MB6039:EE_
x-ms-office365-filtering-correlation-id: 5fad4ae4-90c4-4950-796f-08db2b7cf189
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r1Y3j5aj2pwgjKsbZuX/AoHIf/lWv8hMJlqEjHigS7cEkvey1hhqK+5PfpXZPpw6PihwsjKdB85JioW0AKncWHwjw6R1EVYGY3hKobIYhOCpUncqiyxEatpBEoUzWn+5+AqCxOi2D2xwzQCjxucJsWKxVHiVylcGF6QEAmbjGKv4nF8W0mUOF74YV/OYF7a0fFGIZ1RpRYqgtStZdqzMqrhOyX//DIFMEWK5JJQOZndD/zKq9aDQE6sC18W9zJIIkfv+JRK4M17WQPhDv6ASgvzLMXwZS0FvXXDU4gKMa9YeTleKFeSrYpcqylSH6YHvMF7cUE3Izu3hEPZfiJt/NQqNdAIJ7L0ptYEbPvRZDtgNQyfmzv5+GUCmF3yxtUzdmwkH5E5xRIwFIVa7ofrovZMOkp1irSLn9wHhre0lwp/KhnSALLX6YIG7Ke+uxMbFSisgEYbmXv1/ZevTwo1SrWRMrZaLj4aQ5gi9QH9qwMfegtJ8okBbm02r2qpH889/MjDsbqm7eNa5VH5w2CsUHuUpdGkAAoDlyzxpl2fXFOrvt5OvbnRM5ymWkOO7n9VMZertkskWSinR5M6zaSRZsGZPhOxMlLTaRjTiWi8KoSXDflxPY4nSBPP30e4mpU/kNNVONoVtc0a0CiVz5zjhjOdNBf3NreVINSMSmddcsdNVrC1HpOS0aJJFOsEltoxYONLXe6UH0s5cdIp7HlqCEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(33656002)(122000001)(38070700005)(82960400001)(38100700002)(86362001)(8936002)(2906002)(66476007)(64756008)(8676002)(4326008)(66446008)(66556008)(66946007)(91956017)(52536014)(76116006)(41300700001)(5660300002)(55016003)(83380400001)(478600001)(7696005)(316002)(110136005)(186003)(54906003)(26005)(6506007)(53546011)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MjJRkPOxF5VjK5zUyE85aif6Hq3VMizb57TNVf3mYit8efmW5Gygxvd8qN?=
 =?iso-8859-1?Q?ouFd4rKP5LpoiqstfD2l1QNLMS1A01BsQt/jX3QDyBxkFC7QmrkNoe3EUI?=
 =?iso-8859-1?Q?FqdFaYGDOVlaq71BP/usiAplxwRez/PH27CdghPSqKg310K1rFdkaUcvAr?=
 =?iso-8859-1?Q?o2G51JGXoLrdR0sVpZsiNdoazsjFVEO6MDUHYjKJj1Z5WTojySjmyofMm4?=
 =?iso-8859-1?Q?QpL9o4G82g/SkpW1yyN1PXqcOzQlipzS5X944K7IOXOLknfimo2gLLPGMS?=
 =?iso-8859-1?Q?PoSYYqaUbBJzNa1sPHTopQOnu/j+nqtmub39j5+M4FrSLzI31ScWjRJpzT?=
 =?iso-8859-1?Q?Wa5Olt4wXW4m5AkVpgYnGF8lc4Vrxqdmzr1upy16nr8kt0lZ8sqFswoMhr?=
 =?iso-8859-1?Q?LePoZDB3NqR7njNjGoPgN+bGE7lG9J6NpaLvJmilPRVZOjKRShNKzggLLl?=
 =?iso-8859-1?Q?EWECnOS0RVD1PLnNGeVhYIO7DKmBlLDz8rWDJHDfhnJ39rpUYch5dDkzyK?=
 =?iso-8859-1?Q?kdQnJlI/BuD9BaQnT7/2jIT2Mb7m4jmv6ruGh07upYQO1qFuWA+f4VaTzE?=
 =?iso-8859-1?Q?cfVHIMoDigL9yXsgr3R5mp/HR3lAzsFmYrZP5qHmZWbOTZNs669EXHkBna?=
 =?iso-8859-1?Q?+9np1SdDZK2IcwdGF2pe0zNn1d1mb9z9AMvvqEqSG91PcLi0j9ezsFyf0u?=
 =?iso-8859-1?Q?MfvVhH14xqMCdUMDxWJjnVXh04ppQB0ROLpI2Wi1VILnJKXJErlErXCwC7?=
 =?iso-8859-1?Q?Ogksr7qGVo5kfF3pX/LpHM06Ojumty32u2lYGYpUU1TEeaegxmJBuwpd6Y?=
 =?iso-8859-1?Q?IcsqlHsggmQ96zAjnLSDdPoqujV8RgEZUApZZeck811ZqOxQmnHcJhKvpZ?=
 =?iso-8859-1?Q?4I6CnZNwhoiLlOSLaKCTeXpypcKOqgr61SXlpLlUCSKuasysyxL1ZQHCar?=
 =?iso-8859-1?Q?fIksPaMAhntwA8uT69a2/ktjqhEK8R/qlaygP42VhyeBlJNAVa5E3/JRDz?=
 =?iso-8859-1?Q?g7zQwHeEfXmvZlIJum/Aru7bsG8fv2ydy8UQajUiwW7Yxk7D43z45+BhsZ?=
 =?iso-8859-1?Q?8Bn2JNLzx2mYpDiOMfmrPesvPNLwOVUXiBbcz/53Z1/2+0FNHFA6kz6PTn?=
 =?iso-8859-1?Q?FTgxNDNU1BbtG7Adx83/a1Jpcf0H2/wiq0JdbymLxpUzyJTFcNuOGTpDPU?=
 =?iso-8859-1?Q?J+PTexRifUP5/I7QdsRG1E58xCh2RLoI/rnB1H98P8XsdzX+cv2bjA1Mdx?=
 =?iso-8859-1?Q?3N6ONS6EgH/XGw3hDNsFU/7GiufpSFpovU/XffDHWNpDt8DHdHI8067X2q?=
 =?iso-8859-1?Q?sDU2P1TjQCHzDJrzs6tW2y9LVnS5aXjveWtnp9d8NESyNGo4teqxCaEWfH?=
 =?iso-8859-1?Q?d5JVbkBQ0/dwcgviKxzmKQrnhRlEcwaM7MLxnlMwVVLPfOSVTkj6tLpoj0?=
 =?iso-8859-1?Q?FvJvlGEt4aLr5wo1gZFWi78V80N7OGxo1sIk593eeZQ1KH0Ag43O6VPNNR?=
 =?iso-8859-1?Q?qH1rhSVSoZ/8sItTA2kGPqKIT+g1NGcvXszy8ycBoYhrlzbj6YsGT7zOOS?=
 =?iso-8859-1?Q?Mk4o/RY79IpLxWxWypo1glj8MEiOT7uryfUwYDWk0OYOe4o00gM93+oLSU?=
 =?iso-8859-1?Q?FLAk3pBykATyE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RnQk1+f4/fDrqy86FP/m7/Iud0sBJyC/nHBNTlIVMAe02xFyhXeBCZmGrNGaf6MIF0v4zvz9Jh1PZp7+fiFBVJDX7PPj2PjF3/Dgko1T/oBFSH/dgFmO+uaMHbU9BPbLbxUZu5aK/dM4njeWlQObBMkB5IHE/YQBcrph5s6T4VOThnpQ4vv3Y4vZXbv9RyVYQQouggcuP0OAVhEPJw/1XKIW96wNat7VsVtDxlhblPEUpkQMjz09iChIUKjy/IkvSpSBTjNYmTy5aKBi7GmBblhJXFofZE4WgEeau3tZ2533fOgnP2qZBnhEIbKNcWZpqLrvEDNEY+052cIKAkq0X9MXV1nfd01JUAqnF9sqXauy1Z9+4hFCUp0V8vnQRbiMnEue4mzupOdRHobL7B50jag5ltvLAEXemM7wKW5T3WgYJtLjBwXCrLjP49RPrrnAnVL5QXl75j1hBN1N3YWbNIXwdizx3Qm/AWNV7tIZ+tGGWdr47e+zQHzntnliPWxzx/qiTyXzGy+V37972bynRnNJdk3n4euQwCncovIvOvxIjKcfZA3XFrsUdjEIXPXIxnhPBstD9fEHBxjnP/FgMVCk5AQ/YLe+JhCayZyXu+0apYG4wKW1QZFUBIOIcVm47ErNIBWbFZIZsC+pAsb3zUbJNV446++btp2s9TDqKCaM8/ZnWG6RNgOS38VNto+rZjACLviSWbUcHNKK+9C7vA25xAN3pGt+Ul75dhh0sGOLmwEQZMnpxgl5jeGhc/Ey84xAljMBfwRIEgISU6HmMfwUM+PF/5jCgzLOiuhmLsD89cIdcsQrFS5zv2ajLs+EHZ/cyooOufXajFZ2SEECGvNWfwg/jvwaYNV8DZ0lUOD5NEsDEnFSZjmvfFJcg0Sl
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fad4ae4-90c4-4950-796f-08db2b7cf189
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 08:59:43.1158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5oDdE1jDF+Z18vgJLHlpoAEz8s1H/SWi0v1ZqO2pfsLPI1yGyxoIECqqNbPKLObBn8cM+/hriaB1BSaypbkwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6039
X-Proofpoint-ORIG-GUID: Z7CZkib8OZXdLQiLrSh5SJlFQgtNvDw0
X-Proofpoint-GUID: Z7CZkib8OZXdLQiLrSh5SJlFQgtNvDw0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have just checked the 5.15-rt branch on stable-rt and it is also missing =
this line.=0A=
=0A=
________________________________________=0A=
From: Luis Claudio R. Goncalves <lgoncalv@redhat.com>=0A=
Sent: 20 March 2023 11:10=0A=
To: linux@steffen.cc=0A=
Cc: linux-rt-users@vger.kernel.org; linux-kernel@vger.kernel.org; Steffen D=
irkwinkel=0A=
Subject: Re: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=3DNULL =
again in dup_task_struct=0A=
=0A=
*External Message* - Use caution before opening links or attachments=0A=
=0A=
On Mon, Mar 20, 2023 at 09:03:47AM +0100, linux@steffen.cc wrote:=0A=
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>=0A=
>=0A=
> Without this we get system hangs within a couple of days.=0A=
> It's also reproducible in minutes with "stress-ng --exec 20".=0A=
>=0A=
> Example error in dmesg:=0A=
> INFO: task stress-ng:163916 blocked for more than 120 seconds.=0A=
>       Not tainted 5.10.168-rt83 #2=0A=
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.=
=0A=
> task:stress-ng       state:D stack:    0 pid:163916 ppid: 72833 flags:0x0=
0004000=0A=
> Call Trace:=0A=
>  __schedule+0x2bd/0x940=0A=
>  preempt_schedule_lock+0x23/0x50=0A=
>  rt_spin_lock_slowlock_locked+0x117/0x2c0=0A=
>  rt_spin_lock_slowlock+0x51/0x80=0A=
>  rt_write_lock+0x1e/0x1c0=0A=
>  do_exit+0x3ac/0xb20=0A=
>  do_group_exit+0x39/0xb0=0A=
>  get_signal+0x145/0x960=0A=
>  ? wake_up_new_task+0x21f/0x3c0=0A=
>  arch_do_signal_or_restart+0xf1/0x830=0A=
>  ? __x64_sys_futex+0x146/0x1d0=0A=
>  exit_to_user_mode_prepare+0x116/0x1a0=0A=
>  syscall_exit_to_user_mode+0x28/0x190=0A=
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6=0A=
> RIP: 0033:0x7f738d9074a7=0A=
> RSP: 002b:00007ffdafda3cb0 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca=0A=
> RAX: fffffffffffffe00 RBX: 00000000000000ca RCX: 00007f738d9074a7=0A=
> RDX: 0000000000028051 RSI: 0000000000000000 RDI: 00007f738be949d0=0A=
> RBP: 00007ffdafda3d88 R08: 0000000000000000 R09: 00007f738be94700=0A=
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000028051=0A=
> R13: 00007f738be949d0 R14: 00007ffdafda51e0 R15: 00007f738be94700=0A=
>=0A=
> Fixes: 1ba44dcf789d ("Merge tag 'v5.10.162' into v5.10-rt")=0A=
=0A=
Thank you for spotting and investigating that!=0A=
=0A=
I dropped that specific line while fixing a small merge conflict from=0A=
=0A=
    788d0824269b io_uring: import 5.15-stable io_uring=0A=
=0A=
Interestingly enough, I didn't see that problem while running stress-ng.=0A=
I may need to add a few more, different, systems to my test base.=0A=
=0A=
Anyway, I will add this fix to the next build.=0A=
=0A=
Luis=0A=
=0A=
=0A=
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>=0A=
> ---=0A=
>  kernel/fork.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
>=0A=
> diff --git a/kernel/fork.c b/kernel/fork.c=0A=
> index c6e0d555fca9..0c4c20eb762c 100644=0A=
> --- a/kernel/fork.c=0A=
> +++ b/kernel/fork.c=0A=
> @@ -949,6 +949,7 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig, int node)=0A=
>       tsk->splice_pipe =3D NULL;=0A=
>       tsk->task_frag.page =3D NULL;=0A=
>       tsk->wake_q.next =3D NULL;=0A=
> +     tsk->wake_q_sleeper.next =3D NULL;=0A=
>       tsk->pf_io_worker =3D NULL;=0A=
>=0A=
>       account_kernel_stack(tsk, 1);=0A=
> --=0A=
> 2.40.0=0A=
>=0A=
---end quoted text---=0A=
=0A=
