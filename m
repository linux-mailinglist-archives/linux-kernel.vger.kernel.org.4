Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469FF7112C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjEYRrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEYRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:47:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519311A1;
        Thu, 25 May 2023 10:47:19 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PFAg3L013085;
        Thu, 25 May 2023 17:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=M5Bpkmo3NJQ8L/F8dV6gOi8uoIzGX8NlB5FP3gXERBk=;
 b=Ac/W/Y0lYXv0lVAvx5XgP0N97DghNG0pDgZaAsKXABOSQqCIQW8h9BPOjmUAMffa7EyV
 qoWWeHo7greGenBuqT3lTaIuyZirEANOnatZrzt/Ek3iZWvtO5zoEmIoW/P8hBfZPQhA
 sH4CWiDlAFC0FQYZAvmv17sBH77IhvtYD1IPbCA6o7D6BpwUvg1oMMKLXTy7rnrKJLC1
 hAMc3uC6i5r16oD6yyi+D3EHlj9uJm06/zyiVPOdSMnJwL4RWX42ZL/VrBo4BTcg9Uez
 UIHRxLZh31MS7Jm3psIrHNnq5O3mHim5j0o2cVp9rzQuvPbtK88g/g/+M7SIKD2k4mJp XA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsqgytph9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 17:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Esd2Q9Cu2dkizRQBDoGPoVpZ74Ri3RgP47YO6eDIdjHSBt84jKpQWp65Z6/6tsF8CN3ah0niVpMMAOcbTmlmvITorR10P0yGYalYhNwJDn+EJWOVAP4eClECiAXih09r+QjR8fRs5Q5yTVmCGz5ahynElpS3mDcVtiQp1hPGm1C41QdFwKsaw9lRtO5L9V+GtsyOHEPStPLPF6JIGe75WUwGLm3N/YyYodIXXB5ATo7Tzlxj9dSpuVtqFb18w4PImK4GGo3UUCsvdcTUvUsuJPF3K0fkDntyu29NIVQt2wMZAtq+Yhp+FGTTqj0mB88XSiIPLahCzGKO6+lpbUJJ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Bpkmo3NJQ8L/F8dV6gOi8uoIzGX8NlB5FP3gXERBk=;
 b=OMsATdw57sLpdbQUCSpfmwcsLgGAPHXlhOwAyD11nvA91F3VIqJSMAV078quhztiON04vF3ILGns4d7Ypnu78c9XNH8wuM98d/3k00c6n+TDROGl6lcBOGztmQLA+OZKu/OTPYW6uBLHdV5Lc8CqbP/UIQeuaWxtlnJNLnbf/zSJ9q0X4qcfccKIvHXsjcoQFa5Ir8aMRUmVH9v01yUkdgqEQcM4RDtuNMAF51UYWMioYnK3MLaE0fnvrUWto17lRbMLjNvOqbJPw4n3fSRS3Dy7uIU7qkHCVseqBM7kn4o6a85rWHjdxpwNogvEQctzwRpFPwQK4cCq0EkmBVV8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by SJ2PR02MB9882.namprd02.prod.outlook.com (2603:10b6:a03:536::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Thu, 25 May
 2023 17:47:06 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::13f8:6ea9:6f66:7be]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::13f8:6ea9:6f66:7be%4]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 17:47:06 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>
Subject: RE: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in
 uart_suspend_port()
Thread-Topic: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in
 uart_suspend_port()
Thread-Index: AQHZjuwkAMvEg1WNzk+TdPVXDjT4uK9rQ31Q
Date:   Thu, 25 May 2023 17:47:05 +0000
Message-ID: <BL0PR02MB4564F423D8088D6B6420D447FA469@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <20230525093159.223817-1-john.ogness@linutronix.de>
 <20230525093159.223817-3-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-3-john.ogness@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4564:EE_|SJ2PR02MB9882:EE_
x-ms-office365-filtering-correlation-id: 39667359-efd9-4886-1e0a-08db5d480e09
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: td7TCq76JD9nNYaBplvX3n3hFRCRsH/9Q60lQjU9wqhOdnx8EJXxbCqg8KqD0OkHxvbBgmw0CKMkek1YMATwId58YsYQU8I/rYvB2qsaOcF3vlw0imKpm4qYNkqTYfqvKYxXnhVz8Ls0i7u0ekOJXyBQRNMzydMzJkkp8vL5+5iRiTf8Ad9dmHj3JdAs8titDM68yiZHz4hNjcMc/ftG5G3nEh7D1SH+zxir7HOHG0b2TVx1dXKqhL/ZWw3NyJw0u3G8Ld0NPRGNYd5CRE1bP+shfbbILPNErsTZAUIpJ3MAGkeZj98q2fHeBXmxE0t3x5RVzv+CxeqtrlSvuHZ3qYhafKbo/He1E2nL5MwiSap424E3mbUz++1F7xE+QO1XAFwrlS2gMj2VIrJPasp618blyTWB9/a1KSOkTKu3ihAdYP5RO4mWq6Vfr8twsZfMYp+usRG3Ec69Iu4IK6k6JI3sEBL5cs2x98GOdL/XMRl09FOByTqdHq1KIaY50MtQNglxIy4tKiMkgcbzbLnOw3hYDcRmhorzVcdmK0RUHZJ//PQj19d0SKRGwqo2I/4wAXC9IAZFEAaZPFCZAhGTs2EcbelIhB7iSsv/bn7+NlFc8cI5RvIrEznvCVhaucUl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66446008)(66476007)(66946007)(76116006)(86362001)(55016003)(478600001)(41300700001)(7696005)(83380400001)(33656002)(66556008)(53546011)(6506007)(38100700002)(26005)(5660300002)(71200400001)(9686003)(316002)(122000001)(38070700005)(52536014)(8936002)(8676002)(2906002)(54906003)(110136005)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ABW53iUkILYGPsWLpDZJUL1NRJzLtZoC2/2O+NtJuM/L3JoDbg/awFLc8GHy?=
 =?us-ascii?Q?8PcPLj7smBjEwzjkhSkz2kCMkDEiBTVTjKpRoBadg+8ASHIldd1suolRwr3d?=
 =?us-ascii?Q?dgURwwaZmUbkt2RfB4D0GwTxhdj97Q0CHZGs6QpuaHEY7/2L4HzmLx3zr9LS?=
 =?us-ascii?Q?2w7RM0KnrIHKiDfEUhTdngn6qkqdBv2yERqkoOk6SqtZjdgCK+waNSCdb5Is?=
 =?us-ascii?Q?OciJ17HJO1cR8iGO2CkGg7mGmhBsl24C9DqvXlkxqcZQGB9f4aK+Mr4Lj5Hy?=
 =?us-ascii?Q?mHUXxfLaG7qQY1oA8nJb298AwytmxCYOUi2X/UoLpp45B+1u2dm1XRwomsrS?=
 =?us-ascii?Q?yzKY3Zf/HrTl2FMCqLByQIYUHRG/RPMZYsGpCwPRS6XzijHbV8ME3MIDN7Py?=
 =?us-ascii?Q?SEkL1G2HyEDrize07rR0cVoigwcD2TN0rTJ8Vo6OhC++QplwoXQuMBLrX36D?=
 =?us-ascii?Q?LaMGw7z7Q52FJgf/8R3wgP9ODyGocgU7z4QYoRtOu/GXNvmeSfH6pFGRnVAE?=
 =?us-ascii?Q?A65ajgAE8W5xwh/bORCszBxbP4+z9vl6fItWjZgd6Wj5YGTgdAscW/oNFob6?=
 =?us-ascii?Q?8oZiQjq0uUlQV7j9SzsEwN6/W1KhtfgiIobfqYbZWF2xWXP4Jmq3SUeNHHZu?=
 =?us-ascii?Q?nGp+DC7dpe/DfGB4220Q3bQATwKjZG24IVmzeOUWAAKFL61K11i+WBvIY+MX?=
 =?us-ascii?Q?4XzVCgzdZw6J2Ww9opbQGriXWjX274O61TSkADcISebgPcdqYKF3dK0LaieM?=
 =?us-ascii?Q?XnLR95cLqrsZiePGiXNusmr6+51ul6Yi6JabzonXh99o/HHakfs8Pr8nXbHY?=
 =?us-ascii?Q?pZ7bvdVwi+eQL5HUmFkrCSQetIzaRmvb864sDZGS1HZ+9jbOlJC0fdpmNzG9?=
 =?us-ascii?Q?kS8tHxrbjiMkmQ0qeWgj1XcH7QQIlaDwPYKaVlNPV8wGndpabPkdmsWMzqQI?=
 =?us-ascii?Q?9j8deLlnkh8b46oyGr1M6OUuHqdrLWD2v7TTxJoaxax6lmvoRGUsk0W8zrLU?=
 =?us-ascii?Q?R/YpLD8HjzTc7FMT4q2E81qHe0nmCx28hRE2R/LbGx+jJDYUcBSDo7jZT3OW?=
 =?us-ascii?Q?/eWyu4ZXL0sQsVLwi0vL+uuDfLGpq2Z4/kV5u0GEStb/sJwT4MQ4fy0WiJFi?=
 =?us-ascii?Q?UzS2qPGkVllHAdR45r4uDDUoioDOrFMFoETmzfLXXihfVGncKlmdkOljMHlF?=
 =?us-ascii?Q?nhBPDw5SiJFwPCoE6HOQkRUJ189yuKdFmofJ5b2Hh2zX+ZZr5FuSyO1XAYa8?=
 =?us-ascii?Q?uqoFluUcg3RrNADnsQZ8R4vgT9aidehz00B63w7267J6Q7kXnKemAObh3IGT?=
 =?us-ascii?Q?MO11SFvPdqiL3UrSbYHHfrZwO9ZrUNyAOdYIHzthXXun50x3hTftXsvVoTox?=
 =?us-ascii?Q?7mf8WzUZvSdKLjbL6cuSPMY6SxYtKlxwti4YGq/2M+jf6J+iHOYp8dyusBHY?=
 =?us-ascii?Q?mY3YHanSk0iteqgTc61aQ0MbVY13xl0fbg3OgZLzFgol6rz3XFaPTquDfEc+?=
 =?us-ascii?Q?cEFlHVm2nolM+RrbTz/Yb36Y+w1yq8RLvPgSeXuJDzH0Bfxr2k3rJJ/iZtgM?=
 =?us-ascii?Q?FaWhghWZToIhc0eO+EIq0inyYpfo4U3+m5z92oyU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9UO/o3KOM76thta4MR/GaYG5I0PqrBhgK79bpxnQ5+lmxINo/hZ4rfK9Ejic?=
 =?us-ascii?Q?rNlm0RMM2Ryd1mpnGgY3jYq9Ui/VWXP3pwgNEzHW7yxpDoMlon7OHfBXqgFQ?=
 =?us-ascii?Q?Ubd4QkjOcu+Q5pkMmX2Pmwz/d3cPDyZ4mHPTiXUudsw1Z0+h6cwuFFQ+/uZ+?=
 =?us-ascii?Q?+SbYiVxnTtEkf8FkLXoSflZEGgHeNX2HKCJo032qlVxWuDufingPUOieCGTh?=
 =?us-ascii?Q?rlvXM0WnY60kkYXu3Zvvxwg40tH9h8RYl8vM2eG7EsHwTzOLVwTkl3auatmV?=
 =?us-ascii?Q?xsl4Jju54GG6u1ldJiTWtZiObXLnArNEBP1WOijZanXdEmWvqjhpGymtj0Pi?=
 =?us-ascii?Q?L09tEKE1q7j8c4xQP7O5D4iun14XjcrVSwQOfu1Q0T3X561NJVJQzkM3aNhn?=
 =?us-ascii?Q?dIwcel5Smqya0I6lxTIMRtYZbqlbyxjZMJ8wVEIItBOR048I6PN0I+cACbol?=
 =?us-ascii?Q?AAcjJajAvqtR+03Bv3YICx0CwE5y5bPf1aPUoMaellRxNg2gyIRUrmSU5Nru?=
 =?us-ascii?Q?oxtU5din/J1Mfi910rPSChevJsUUACznPcaONO3m/YHqNSReaGpnD8EATYD3?=
 =?us-ascii?Q?GKomrMt+A389FDkiHGyszzTtNNsoz/f4YJvviarwnm6lyYRBj7w4Zd569isv?=
 =?us-ascii?Q?C+MSMRLE5e1/Yz8SWMHTC3fh2sDpH6NejaCs2Q7TwtEbfigH6eRiTDAyJ/sQ?=
 =?us-ascii?Q?OZ9r4LPgfzA1CB6zmtU5xBIs8Yg6nERQ9PsPtHrowKNQKbjjbRXewxhKVZre?=
 =?us-ascii?Q?M/Gb4zdXcZExqjhAKLkjv6oKYUvDZvS8dVhBFfEBMujAVyyGuK+6DuKqbCVD?=
 =?us-ascii?Q?J+SZhVF0j5Z3vdzorgIgYnSWsIAFq1/TjlxTxErZ4MGZ6pvKn0JUXyJzRdoB?=
 =?us-ascii?Q?CwJkwObw7m1iG97ZQvbaJ2VnAQCjbc2zF+eTyd1sC3YFnwHtn1CK7lv+xWji?=
 =?us-ascii?Q?7NG1hpOpDDKEMH6oe79jVw=3D=3D?=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39667359-efd9-4886-1e0a-08db5d480e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 17:47:05.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XKl3hY9/vFosUTHXlzBjdvJ1T30AmMjAYim/uaP/aGoDz5q89a77sukmtH2Cyb4xDvFeqWHo9BE8JvkzQYESk9RH5Cc49KR7H724CjJM0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9882
X-Proofpoint-ORIG-GUID: YwMLeO0UeF1ThAvWqsH-O0XBK_GlyNOG
X-Proofpoint-GUID: YwMLeO0UeF1ThAvWqsH-O0XBK_GlyNOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 clxscore=1011 spamscore=0 bulkscore=0
 mlxlogscore=906 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250148
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

++Doug

Hi,


> -----Original Message-----
> From: John Ogness <john.ogness@linutronix.de>
> Sent: Thursday, May 25, 2023 3:02 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Petr Mladek <pmladek@suse.com>; Thomas Gleixner
> <tglx@linutronix.de>; linux-kernel@vger.kernel.org; Jiri Slaby
> <jirislaby@kernel.org>; Vijaya Krishna Nivarthi (Temp) (QUIC)
> <quic_vnivarth@quicinc.com>; linux-serial@vger.kernel.org
> Subject: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in
> uart_suspend_port()
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> The uarts_ops stop_rx() callback expects that the port->lock is taken and
> interrupts are disabled.
>=20
> Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for consol=
e if
> console_suspend is disabled")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 4b98d13555c0..37ad53616372 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2333,8 +2333,11 @@ int uart_suspend_port(struct uart_driver *drv,
> struct uart_port *uport)
>          * able to Re-start_rx later.
>          */
>         if (!console_suspend_enabled && uart_console(uport)) {
> -               if (uport->ops->start_rx)
> +               if (uport->ops->start_rx) {
> +                       spin_lock_irq(&uport->lock);
>                         uport->ops->stop_rx(uport);
> +                       spin_unlock_irq(&uport->lock);
> +               }


Looks correct to me.
Thank you for the fix.

-Vijay/


>                 goto unlock;
>         }
>=20
> --
> 2.30.2

