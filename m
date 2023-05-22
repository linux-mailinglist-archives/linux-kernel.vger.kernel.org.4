Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3170CE21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjEVWkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjEVWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:39:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C310E0;
        Mon, 22 May 2023 15:39:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNrLS021966;
        Mon, 22 May 2023 22:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i2tNCVSB2ARIHSWhrraeQzys5PE8+nGYoGZWpbGy+6E=;
 b=NfzBAnkZeBZ4UnsPcIBnPRzhVnsMA0mpgzUXE8qeylcZyu7KPqvmFjywBaL5UKKT7lx1
 alD867cu7r9vzVYg5BP1adQkhVrTcbeNyRgzCue7DA+0BavzEVqKXILOzyN8D2Uj4vnC
 BQ0P3BU1cOn4I/6evpso+Lz4UtYwZTeNXfIckujftKWTor3chZXC2Pv6lzoJqSJ8EZTO
 ndk9uxuhditb3Iw5KCKyavVMiI3DRGSvn5GmGu/je3FIFmvfrQ8aTdqhVNO/lx8a76Fu
 6wZ9+w0KTaxQudnuUutvxBcQe1OtVElDrBJpgnWgn3b/XoJOC5YuWmvtUUHwAb1qkdIL dA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qkte9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:38:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MM27HH015947;
        Mon, 22 May 2023 22:38:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6hjexh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL25YjPhDl0R8bcqwZGt+KYLeOd00j9WiL/+YCS9c1cTxaUP5x0yPsovORQ5AABJNSL24lSNXb94c3EoAehwkwEHJf6IJc+Wb4Fn6c2Jyqa9Sodt9uoJkwNMAKCPrWOvQw2YvsVvJLP/lVvsp6inFUHI8vAQutkNyvTkEYlj5TM6IthLR1IsYUvZOaUZO/xHhw5Y6PoxcWCK0jZZetjLwc75MP1OV+S8yl7aruyzhw+C7cJRoNfZoZgA+moKxaDjv4aPU2qHOBc+/AYOoJ5Q6NlGguqEg+Lun7VBdbBqZdT3ANtLZy448NCUMZ8IrnZi0N3Hh9pUvFBV/s3Ww47Piw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2tNCVSB2ARIHSWhrraeQzys5PE8+nGYoGZWpbGy+6E=;
 b=AKzLHzZczKcBHMewZPhVQ4FYouL58MOS4HdmEZRmSaTYWtIOlu7uB/H8TayCC1ljgR8vcJE6r5Hcm+VUV1/9NELkjRh5iNOYoi38Clx2AEYWZy7aopKu7DlNJlonhxjnwBkwNREgmOz1s0KHFyTzNTUdOst9aYjkZC5DySr2ZP2XfuIkSgC81Buw4b/lzst7xNjp7mSABv/qaum3UXyxGOCqXOUPnBJ9jp1X51t7uKLobHBnTXYYQCucvhF4pOPQMrou3Y343LskkxZibPl7P+DWDYqdOWwHyY6NIiLrPcKA3pBo+mRbctdlM/S7jK6Ig/YHONWIUBqJ7I0voZ1l/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2tNCVSB2ARIHSWhrraeQzys5PE8+nGYoGZWpbGy+6E=;
 b=wRMGX9V2hbvf2F3sTPfGGzE3Pw9H+Au27IT70HIqmARraE1MCkDz6aQbohFq786HFRRbcRWTA0tV1ylJFHPyq6lcIP16Lh0FkcH/p3mGzyCJdF//ePSUiGLbaCajQnqRoPFvOeUn8+JlX21+JXUfoRnt4pRaaaCWuu/epSzOqd8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:38:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:38:53 +0000
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Gerd Knorr <kraxel@bytesex.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>, dc395x@twibble.org,
        James Smart <james.smart@broadcom.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        megaraidlinux.pdl@broadcom.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 00/11] Documentation/scsi: organize SCSI docs & make
 more readable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edn8m1os.fsf@ca-mkp.ca.oracle.com>
References: <20230518212749.18266-1-rdunlap@infradead.org>
Date:   Mon, 22 May 2023 18:38:50 -0400
In-Reply-To: <20230518212749.18266-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Thu, 18 May 2023 14:27:38 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0036.prod.exchangelabs.com (2603:10b6:805:b6::49)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: fb7cb780-1ed5-4ba4-f708-08db5b1551ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/0TWqtTCqaezyqR2+Ch0eLcAz89Y3TyC8b+2tHNn8SHCwHa6triXWqfpsGFPeoXYahqOtbUXgwHj3MZupHmfkhgBL167vIJLa7gUZceBjyLOqC6Zph8ElOTwhTYe/l+CWKdrYuiSKzEFx2bn6sJ4toH+odyu7hBI+VlnfxONb+SAdBLV97CxGE/cVnG/+f6FpRnJzd0xaeVQwe4to1qAxSHfyi2Y0a7TOzRTQb5us4J65nbPS25JOzMXtujUeG5FsI7O9H5cX+yfWWUHtMZqqVFBZ7g/k597pv3RTZvDZyDhmF/K1U5N6OjL9uFhWzyM4CYauRmioVgsdk7rz5cL6p+77a+YkRkqHMmyD80fbGQOcv/KdIT0chx8IJJjgHcyQ8G4zlsZFZBBnsmwp5HrtefMLavKakgEYALSWxRaaBvWpO7ydB8gcRd51lhh5Bk2OkAIC5QPqIayfeGmQ+WiZan9X0uNEpHhORpoUfEoc/x6Y82V6jvydbnECB/3L2TUGTogBYfTG7XN/v4W4+cpgx4wWLgCeA5WhsJMwFPPcwjxzS5pRgVoERHYLIRNcki
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(346002)(396003)(451199021)(8676002)(8936002)(7416002)(5660300002)(83380400001)(6512007)(186003)(6506007)(26005)(86362001)(38100700002)(478600001)(36916002)(41300700001)(4326008)(6916009)(66476007)(6486002)(66946007)(66556008)(316002)(54906003)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jmj8xo2RTKrqjthaWyS5hPwAQ0xVsG1oQUwVS23DBrnDshJ5b+h5l5KWdEVO?=
 =?us-ascii?Q?d3mqYFediWLi/QvAc+9u4qtdddGrgdR58wuPYrVXtOuanWlvzm5eNJ6pU3mP?=
 =?us-ascii?Q?d0O3Em40LN9poOg6xBrXcljEmb2Fq8IWrkcMVzWKApNcxKGEA6Y5ZlxbwQn4?=
 =?us-ascii?Q?BDzwJ0omCK4dVGEtvPIlUNIZEqr9xYymG4lFbO1PfrK7G7oH3jdz4ZDpG6Ox?=
 =?us-ascii?Q?ssMvajua7nlgG5j8havT817K2uVYh8M5koW6BwJr9OMQZRuA6ZQkeZ9fAYbz?=
 =?us-ascii?Q?GpJ9sZ+yrE6Wf4pgha9yb9O3jfTmLMyva7uZ1GRZgxlReXsUZ7ZADcBgUBcT?=
 =?us-ascii?Q?CgternQ/4+EqRcaCf8XBG/TLVueklxQYdqY63QusqE/vQKfJ6DTTT3lBKrs+?=
 =?us-ascii?Q?+c+jZ8Xcjq+i9Sqbx0U+kmFG8hbYQ7bHm9jmE9yckWelPNVk5l42+Xmi8QDF?=
 =?us-ascii?Q?QJpQ2e6ImPcdiSbYoT/34Kf8tUDaumfXQ+oxLd+9yRw96Nzn9BfbvG/7Baah?=
 =?us-ascii?Q?paGgQnfes5uhgcTHPxLwVwq3coEqYIzRx1doQULU8rhGIRFaMEprypOs4liO?=
 =?us-ascii?Q?P+gKCjQbLABp/hRqv7No+nVFeIB1rC7rAnHyjUUOBhA3HDL7F7YhupyZwJye?=
 =?us-ascii?Q?hjGMfNDvijmYI7bxdFokdukub78q30OYYEo+iJsLuQuKeyMmSxMXkMES7OgT?=
 =?us-ascii?Q?eyq/baBRdKVH4TDSPJkRlTEfgM9jGEiWbkvDb0Amh7+zAR9ZBJnKoPcTA2Ll?=
 =?us-ascii?Q?vZs5+1meZzn7ByDT4ZkhD6LsnPB5Fo56iaWA8ohf3VvmJfe+LX2TGcWHnPci?=
 =?us-ascii?Q?tdizIB/ZADiAb1rIL2A5vkR1qJ8OSZJZFgI0aeV9VEcQkqqxhSkeB6GKfRA5?=
 =?us-ascii?Q?eJEpDDiOqC97tRCoGNGThfNeyJAVfLVqngi/ZWBhdv5MWWdYrdQ10/t/Ikbu?=
 =?us-ascii?Q?xUEISrZC7Alc5hlhnCtgNJ44b2881m0c6CWpdEaaZU0fKCwEovlrhG2hxv96?=
 =?us-ascii?Q?JMfRF+S4jS9p5rHa/4qNr1d03yoTabFSbNDo7Yqr6YCDz86quETZ/sSzVAX+?=
 =?us-ascii?Q?bu7Zv7HrI0xddfwAOWsewPeLz8yYaZ0LmOHVAohtnSXnU87D4PoC2H5sz5PA?=
 =?us-ascii?Q?+oh1Ox3IjFlCoqrO28Fa1lx7TOKqA3uz+chiFuBl4+TdrGnrZ3Vsn+eAh6eu?=
 =?us-ascii?Q?zDCJXjPg8CKYqqSbFiofhJ1Ownu4rjuNKFGW01Ypdy4aOMfhq1EUsFV+F1W1?=
 =?us-ascii?Q?prR/2p0xe4ZFpUZvrBxlj+YFxRo7VQDO47hkOUbcCWV967ry6B54dgmRnENt?=
 =?us-ascii?Q?XSNiibtOKkoKNm+BjUw6MPXklJV1VrOsxcqK+Pj8Q12itdkb2855vbPMQIf9?=
 =?us-ascii?Q?VBGGx9gkqV9OS4iiUfVFxjEaDzzIZk4TYL+h3xwwHmm+GPLl+VOETsGQCE0z?=
 =?us-ascii?Q?BhtfyIwf6mGbMQAK2bAXORgST1p5BlaqzWAmNJWxZyjWeS8Fj/+U7heKKLPz?=
 =?us-ascii?Q?WyVAJ3tuzfiktEGuKlSaJpCNVHCtnMrZnk/KxsIln7eCOkevvdg6hvM/ccLu?=
 =?us-ascii?Q?WPuwg6argf2duQCnoBzd1KgAbiCqIVRPOE4c5Ux6rca1bGfHrdYrp/E4k4KY?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?r8QCg8GfgIeibp3gdnyna9EQZKToxn2lh4qyp8paVqfOk2bmISVKQzR/57+p?=
 =?us-ascii?Q?neMfL9olcv8xseDZImGfkY9LDf/Af76Poq/RJwuYnRjiw/CMNBOnCS9k9/B1?=
 =?us-ascii?Q?7nfts2U5FNkea7ed21AqJsWcKt2zfIaS/N5XTv9HS1lesj1IY5kKwkWQE9Q/?=
 =?us-ascii?Q?+gjHQsO0nTRuK1KZ1CJsft4RCFcs3xpLOplkQa6RhLivs2GWsFjGy/B2KAg4?=
 =?us-ascii?Q?+U6TB1r/F74MUti0cV/R3ydhb/7EmsU3DOlYY5UQqu8blRMqdcWYhMtmPiHF?=
 =?us-ascii?Q?EQYpRDQIEEI/pW/0DnOourXhZDxhpGN/onBNphpQHPPUqvjbKQ31gQv87t1X?=
 =?us-ascii?Q?3YES2anxTB3IrnGHYtgjfwONMbfcyXzMvQO1NyFM0O25eVJ+/f4m4BF6sP2P?=
 =?us-ascii?Q?oqlsi4DYqOVXtZSJkCa3tT0NhkIdMuSfOah2FvSvPVEP36kGnpGdb1rpSNl1?=
 =?us-ascii?Q?bY4CX5p/ZVGVJC0Egp8z9WFofRLY/DboTtW98XqaSiCSLKOTLpMuvYHKSwOD?=
 =?us-ascii?Q?BlgHW+d50X55Oiu5I4Cm61LGtkuv6Kwq/8vePIBnBP38SnoO+pDso9E2gsUI?=
 =?us-ascii?Q?AWumXlNWpQvC1kSF0DNOijm7hFgsGPvCEUSzDUbyncuDF9A9G1LV+XyrzJZ3?=
 =?us-ascii?Q?bHU5B+/FG2rtLIuUlW7h/i474us0eZmt0UreOMZjDTHEb4pDdyjO5NV5Ockh?=
 =?us-ascii?Q?srtoFWw2vkftE3JDkez/N9Cj6l/IYtLZyDUThUA+xJsq14v5HeyYtwt1F2fm?=
 =?us-ascii?Q?54Gp8cgcHXIfzoR7reQUzBLeH3JJvULP3k6TLlB6BEhX7E0iI3Mhe5nkLeAW?=
 =?us-ascii?Q?vkI+LZrLpc5NoffECN3SmFpYBDod6MRo09tDZoEtfGVFwzq0IVOdiHRzaXPB?=
 =?us-ascii?Q?RUc916uRDsXX8EwjMwA9AbnF5DoW4NtWrhLFANnlgkA4S4bN4MdkYyXhN6Ok?=
 =?us-ascii?Q?g5KTxhSKf8H5DuPPBZqPE7KAyLDpmcSyzTtRuQK4fDbQlCmlsqvFlp5WplOz?=
 =?us-ascii?Q?DKTRIbrtndZ59zvYfR9Q9dw4MJY/+zjMX8ncNt5hT303kbpGnEUBzZ/WP0eR?=
 =?us-ascii?Q?rxTWEPvyLfVr/ixFjofZr6skV9sLXSBcDfT+pQcizye1LjHgOTg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7cb780-1ed5-4ba4-f708-08db5b1551ff
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:38:53.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BozctjzcDkTKLCPNEjBv2BJRewKPAmRHCKDAoXZbv8/zLyCjDZsmDejrLSN9tXSlRkGvxjIaP75lmdwFaLlS9xNAiVgHuMDBGWVLujKanPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=949 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220192
X-Proofpoint-GUID: rPhFsls9dQFq8vSWMPlwR86lUpSu7_Df
X-Proofpoint-ORIG-GUID: rPhFsls9dQFq8vSWMPlwR86lUpSu7_Df
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Randy,

> Organize the SCSI documentation into categories instead of
> alphabetically by filename.
>
> Modify several of the document chapter headings so that they are
> shorter and easier to find.
>
> Make several updates to the scsi-generic driver documentation.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
