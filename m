Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7EE6C65E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCWK5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCWK4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:56:46 -0400
Received: from mx0b-00209e01.pphosted.com (mx0b-00209e01.pphosted.com [148.163.152.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A51715;
        Thu, 23 Mar 2023 03:56:18 -0700 (PDT)
Received: from pps.filterd (m0094032.ppops.net [127.0.0.1])
        by mx0b-00209e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4ZuBf012562;
        Thu, 23 Mar 2023 06:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ncr.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pod1119;
 bh=l/RMG7cOHL1KEh12Vj0Z4SIrALgzLDy8rdtzt1jQDXI=;
 b=pdt4M7SlCwY6vsxL8u/8lImytgkjqpsAPbG3vloW8zgT6kbBgyB8/Ys7Gg9COVXV5cTC
 dnaNSz+vl7rndhlaNH9zocio5wZNuzkqgQxM0Q9AMZloM3Q6KmUkkxc1pfZEFv2rSfwJ
 N1bCKd4TFLg3dMZjodxJXq1/uEPssN3T51sxEde4W6pqGyzxiW8wHun44cCcJ3t43/y4
 AcfMoARfV8rYwjYvrUnWxQpuz/xZww8KuAMjw1AwdN+dA80ycdGrzdXRqQ4Q+fdIKnwZ
 GFFhC2A+sNU0qcuCnlFCFsw8f8NKjekiffZGAu3CEBeZHiGK81hM4Kq5/pjNmJhIRNHF qg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00209e01.pphosted.com (PPS) with ESMTPS id 3pgfvn9w1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 06:55:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIxhpbRLQPMFnaCxS4X0PuaaBYFhKtidzjaHYatSZn4LOWcAcJ3i25FEajJWHHxEGU1qQJF+vfmD5ikh9zEJUCr8sGS8DyePGG5SXbRlcgky9cGrW84/+O3hwSpw/i+/mf10TN1FI4RHXq7hSDK3osUXDU5HXBFdSKd/LEJqxrhlJ93Z32lcTJfu8X24vZMuv16NZ6C8xuQWfKtpXcyIIFiIFAmyyrFLSbJZaZCw+CvX0XMjfoDGbnZkMprk+HICSSvObg9G8PP8Arr9sQ5L0AbqcAgypjjzZRHmED8nmqtXV6YTg84xOk99TF38SnNotY+etrxC7aRmRg+JvnzviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/RMG7cOHL1KEh12Vj0Z4SIrALgzLDy8rdtzt1jQDXI=;
 b=cSNJ7tSF994Jc0SM0ZLi1V3cLY9u22DqQ1XEyhtJR9+Ku55vKKr3jGFyeheAPecOiYgY7wSbJycPXq1XeDuBaTqx1RdEZyPagO6AzWo5Q5Zp2qTErfCgROCFCR923iRZjnrg5SrJSsaPqJ6RQyV5QBMUt4tbBotOEi/uOqazANeUyv8c5Xy1O7O0kktSQ9226dMXaMcydckV/+YkqmSRppsmeZ7Db6ybX5IWD8LUDPnoGGhIBJ2DIgbmoCcGJ2aaJbmytdeLlEoTV1SPoBT/xWIAzfPRIFQ1wrq6FwlXPu8DWijNtBeAQbds1OJtEjGyfDNYfI0xUt2RI/HA5fWmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ncr.com; dmarc=pass action=none header.from=ncr.com; dkim=pass
 header.d=ncr.com; arc=none
Received: from MW5PR15MB5218.namprd15.prod.outlook.com (2603:10b6:303:19e::18)
 by DM4PR15MB5519.namprd15.prod.outlook.com (2603:10b6:8:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 10:55:55 +0000
Received: from MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325]) by MW5PR15MB5218.namprd15.prod.outlook.com
 ([fe80::fb77:675c:d292:6325%9]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 10:55:55 +0000
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
Thread-Index: AQHZWwKU7AYdn8EL3kGBdr8btuge0K8DgwUAgASRkcGAACFepA==
Date:   Thu, 23 Mar 2023 10:55:55 +0000
Message-ID: <MW5PR15MB52185AA4729312EF50F7D029FD879@MW5PR15MB5218.namprd15.prod.outlook.com>
References: <20230320080347.32434-1-linux@steffen.cc>
 <ZBg+3pGG9v+hQFYI@uudg.org>
 <MW5PR15MB52187150E6E98BB7DDBB7335FD879@MW5PR15MB5218.namprd15.prod.outlook.com>
In-Reply-To: <MW5PR15MB52187150E6E98BB7DDBB7335FD879@MW5PR15MB5218.namprd15.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Enabled=True;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SiteId=ae4df1f7-611e-444f-897e-f964e1205171;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_SetDate=2023-03-23T10:55:55.217Z;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Name=Confidential;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_ContentBits=0;MSIP_Label_dc233488-06c6-4c2b-96ac-e256c4376f84_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR15MB5218:EE_|DM4PR15MB5519:EE_
x-ms-office365-filtering-correlation-id: 8e88a2c8-a1ef-4207-0671-08db2b8d2d81
x-from-ncr-tenant: Processed
x-pp-secret: m9yph.359rsj96jnp6w-uuxnb8thy.9r62ir35fve
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HKXdrHvDcxC3GnHkSKhU/q8mgEnjAZZAlcd2WPLxE5h4miy8GM0LDjrnJV8vSdJ3+L78McD4WQxzz0yABUOcyckPOLykqJKY1X/FvSm4oQuQvPAPlbIxCnoK23dLZlxpbr4H1HwHZq666LPuw8djbsv5o3BH2cxCTGRcDXBI6d0LYYb1FfJmLoUcIO1Ug8xFLALBqaFC4unb0uWYEX0IgrT4Mt8iqQgTtjKnmmYuWnZ8PFd3rtoRCC1D6PkzaY4IXHEC/4p9P54cHfAmn0a6Rwt9fcDgxkT4672unZAcY3BRxTURi3NmR2rtzTaxitJFlBOcEQU/SXZgwWmv477JmOvTQGphBUiXpnphMsNVKV3wBV8DSHorch85ADUq8tdoL1HKO0hWSCStsJ/ke7odLCZT4nc/iXPtEEu6XWzu/VdTAhHHHFJtbbN1zsQrTFJfxIfmXg35k6wemjER4pZO4tr3TGsYmRTA86uEkEiqMjCAKMhccnSEt3GQev6LIiGHS1VHo945TBE/dd55oO3nd0XToZtsk76xDvVazP0QQTU1A+qJZKuZwW3vcAOaptHnEr3pryJ4H3trtATuNdXwFCqizPBDYJWnejMuxawjdCAYTkDjZR2xX1KKhi5LzyLjF7TYPT3cEV5Nsf0jyd0Ew8SvBK1ifBpT7gthwV+Ct67Q0O85jDCEj36XN34CrvK8B4JxP342ljyBlzXwDJD3wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR15MB5218.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(55016003)(38100700002)(38070700005)(2906002)(83380400001)(71200400001)(478600001)(9686003)(186003)(2940100002)(33656002)(86362001)(7696005)(316002)(110136005)(54906003)(91956017)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(4326008)(76116006)(52536014)(8936002)(53546011)(26005)(6506007)(122000001)(5660300002)(41300700001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xH0xWSpq0LUEybz976gCiiJF/e6m06cw9ntNC5kw/X0f1o8GAXVhjrkIla?=
 =?iso-8859-1?Q?tBQYLEATpWSAv0pgFZWJgfmLkc0L2jTc4AgoP96ejSD9SeNjJNl5OF1nvZ?=
 =?iso-8859-1?Q?Nyfy7SoVkxS+D8DJynNSPU8h4Y6q1v1kJQXNcD75fabDZK55lBhgAITv8U?=
 =?iso-8859-1?Q?OJDgbeeYUMpzP6/oTyIRJ3Cvji2rlyUjuSgtgS3apFPVgp3NBa4kTHOGMn?=
 =?iso-8859-1?Q?BSCvNxgswpCmDTK/EpBiF8LS8vv/GsReO9298lXdGrG8gQk/J2G28hI/EK?=
 =?iso-8859-1?Q?A9wLQM2GupZds0qZqk7SBJDQ4nyJYu+gsOHzbxHnjKK4gW5oiOsx61lKQa?=
 =?iso-8859-1?Q?Dl/KqXWzLlho1MNpZGbsIcQM3X3Po5Z3Sha1exKhgach3KmbujVnDz6GA0?=
 =?iso-8859-1?Q?sYN6TUrq/ta0x2SQi7d3WIDuyQXHEpjeMvfAGYyO9OX5hCT7G1g6Q2/Ak3?=
 =?iso-8859-1?Q?3utu5Mu6jWHkwCifCk20TiJqXK8VjDTkdumpZeJ6abhigxUZ5k+60xxpeL?=
 =?iso-8859-1?Q?wR7GmH+SeCcrLsQk2HjvOjs9NOYQ0ZFqQuDUXOoDqgPpams5I6N0UVDNUA?=
 =?iso-8859-1?Q?+arx/JbQE2XazzQyJgDpJ+onTWO/lH0y6hpze3yhFy65qhU0VskEd+153z?=
 =?iso-8859-1?Q?3eNk/12JKpxeSFG1yExEbP+RGE/CM+mKOJtIlCMYwX0V9L3LXkEJTA+ORl?=
 =?iso-8859-1?Q?O6Z2xOfAbwE5Z6ZNB19PCF542bCkDuuMvcOVxvtOYzwRROxdhL5GqiVE68?=
 =?iso-8859-1?Q?VOynKgS9kFBXcRum3Lso6yVMMAMlMoPLxOeXtLewKO2z6viJU/eriXil73?=
 =?iso-8859-1?Q?qExxRPRypQWWbvYv0Bt9gkcrdYKG+kjr95oANn4ZeMoj5/V0D3OiVH8TZH?=
 =?iso-8859-1?Q?LZJUl+iRPlz4eui4KQ+SHXZwJv71a8PXrxleFL6iUnt9bh1gsS+Ga3vORt?=
 =?iso-8859-1?Q?hsupcsVkEiK6LoEpCPLmlFEK8Nfkq2GgrUXPe7STpIR5iMRfj0oWE/zUrk?=
 =?iso-8859-1?Q?9WvJqjd7TEueggOgACXiXYRiXBhuen+SN69N3glOI/2fWNPKxPaJA3D8Rs?=
 =?iso-8859-1?Q?lTFYmB3FNBsWOJd+0/QYjGzMwnyUdjSeVlf5QbC37S1LHO0hfrIncKaK5y?=
 =?iso-8859-1?Q?er0iA/yENeZ2EyU1/mmpGDj3eGlnQ6DAWc1pDzd/9BI9G2oJ29BrQ+QYdW?=
 =?iso-8859-1?Q?ZdcwxHGB8Sez7K124zF2TtQVNKFQ3n2A3gxAq6Q+cn4l0o0vmrI7YRS9HN?=
 =?iso-8859-1?Q?mUFW1JXXM97+UQX4p6VxtUuZf++nF8pW5zj352yaGey9wNCShflTFvStQE?=
 =?iso-8859-1?Q?KKzJqYzhVtHtZvmWQJdHmJ+QhVQ3ZmFEq7y/iI+IuQXxNzWk4wMzgeueY5?=
 =?iso-8859-1?Q?8h2x8r9nRFL/x7hcQB+PaiIofJ0/JqDi3CJbnKMcsMI15GvBYqW9ej+ukf?=
 =?iso-8859-1?Q?beow6HTQR8YxWysJt27Ghfc3nttj39TbCoQ0097R9MQzr7wmPM2cyN3GxI?=
 =?iso-8859-1?Q?Fuyz8UZWzLevd00+xEaDJB9xf1ZnXwKaYWYs4YTwO6QKt82VP2UpyEfplW?=
 =?iso-8859-1?Q?BHnSXhY/V1dXWZ8l/PQ5Ufba8UYuQBCcxeBogPrkYtPKbOkEbjuLANH+TJ?=
 =?iso-8859-1?Q?NnFxCRAh37kLM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ScqxW2CfYEQofsAONWBpLfYRMB0v95tT9c+sAk7osgpqixfgRDr+duJ6/VdssOggxu6PhWTS8vbzk+OR9WJwW5BFwCBFtdGMFNXkdhDGmM75IEBbS+j9tS8RvTwpS5/0jr5c5OBips5gpQ4jvlZKOaxeV6EOV6O3PMj3BA724GUz4cQSRHq7IvCnfOIENzhtP88YsJ9qWLJ4xjlU8N4tk4FA642Y/reMVHgk9zru06R/mNh+qbB4F87S0ZaaJHnQDqRDrusNw56h2rAMORzDPRvXYyKzScEc9e5q9CeQh9PbJhRcH/AbDpfHCC+L4eSGobM5c0rWFrvS14pUL3c9csh5lb/HjH+MOBx7zhs7J45lLJ9IKOraYsXgYWzwtRpoiwEHC2iWdAMBgUVMlD0FWcrgMG+XgSats9eMdPN4/P/nZFD/RW/GMqUK0l4vmSp5hKFwOKpZ7u5zXog3EbD1FSRgEOStuxRI7o/sOH7yiq+3TmdPfTbwmA4/t+K+pQWr1txp5UtQ71ls17yu/yCZTuk/N6i6i6+MdvrdbN+RYroNO8blcAFAulrCZA1Iq/tQe0oS7OzrTKc5aeKRdktuos+18c0MVYRbgj/fmYNfK5CTytevxclTwTxC9ElAUfsrRKclObOcI+E97IYWVyP2w9t/5rxg8mUN6jAdVhdWW7QCRMJVZ4nqKq1oOQpTS/HSUMgq2ZOigVqkKcYktHDgmiPqh+Fm9kvbaAMPLwDxX86osbDX1p6S5simuOgH0tqoAyUU3cb+5NWRnmO6dM8DDRMgVNv3zsR+kCdMAaP59nmKCom6k+H3g7xIBFrDDHeZoMgLzXnbCo8o+N9lyoo/txJCDkrDgYUx3X5+u7lsji0mUkTScOwAGOagKXJA4Xvg
X-OriginatorOrg: ncr.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR15MB5218.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e88a2c8-a1ef-4207-0671-08db2b8d2d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:55:55.6401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ae4df1f7-611e-444f-897e-f964e1205171
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdLY6Nfb+VzQ2YsEVa5gE5aRiIIR9rzdIevsgqcyNu9ptJM0HsSOdvAC8Uu5eWgAilDBo0lAKyGcSLi4kqZCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5519
X-Proofpoint-ORIG-GUID: 463LqfMU43nCJsn7qA_go4BRsEV1mcdp
X-Proofpoint-GUID: 463LqfMU43nCJsn7qA_go4BRsEV1mcdp
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

Sorry - just ignore - I now see that 5.15 didn't need this change.=0A=
=0A=
________________________________________=0A=
From: Leonard, Niall <Niall.Leonard@ncr.com>=0A=
Sent: 23 March 2023 08:59=0A=
To: Luis Claudio R. Goncalves; linux@steffen.cc=0A=
Cc: linux-rt-users@vger.kernel.org; linux-kernel@vger.kernel.org; Steffen D=
irkwinkel=0A=
Subject: Re: [PATCH v5.10-rt] kernel: fork: set wake_q_sleeper.next=3DNULL =
again in dup_task_struct=0A=
=0A=
*External Message* - Use caution before opening links or attachments=0A=
=0A=
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
