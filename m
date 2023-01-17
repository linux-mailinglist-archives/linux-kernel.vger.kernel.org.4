Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2E66D543
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjAQEOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjAQEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:14:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCC9234E0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:14:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09ZsD005646;
        Tue, 17 Jan 2023 02:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CVkOl8Q/nodkaO6l1rJs0OnFVAPjOYnF9i1CIp+QF50=;
 b=cTPUXlkWuKm2f3bdNeNmVCRHMfYMUb+NFe5uiGsfPGMPZwyXWeYQft+HxMZFYNG8IpSn
 qUXfo3gmZkZLK9F4nLRKrvah/QLIXZNnX+TpxrhA4p6iyuZg+wDmCSoMeUnAccT1ELV+
 pWl6lcb7OrM6ZlLtHZ94kQa9aQj0oezRZ1jbGNob6x0HO1VMWDfILpIqNvY353XpU3DZ
 kHr+JBb4/0XFXEmcDzc6hqiV2MTnD0dShdktsCOMXjbdVbWOe1E1mMRcZmU5q2SLsksD
 OV+QiVEOXI0LhPlH0VjYL+qbfV0JaQzQQGWjaAxnmfUKXwYZqOQBrcr/W3bZJRDMIQVk rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:05 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMXP43028373;
        Tue, 17 Jan 2023 02:35:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfy4x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5qIOZ2+nIIGDIyHpfbTQnzEmeSbzdpeAlCFizd78RyE8w4/7h9n6xFNHTUJplWSilKhVspRNyeswJmd5u74l52QH/TxTYJ7YSEqJVV3q436G7zGoXq+rinvyYZppQ/3JZn4dRbqPW9m35j5jvb7PY7Z7oK8OcGKwbfcTW73ZaFztrNWFXtm4QCdbf+lJffIFAUzOgoXSERO5lxkY+fZW7h82WDSl2xIyqAGwTae8EAFimAF5B0HbpDDRmnM07i0umLJQJe/0vkvBaec0NEqcS0zj9P8HVDfFy7NDApnPXC8tMeaV2QvL99R/b4fVKbnrNfpoSztLMlGNNIVE3VBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVkOl8Q/nodkaO6l1rJs0OnFVAPjOYnF9i1CIp+QF50=;
 b=j+WhLC6Iy9nSV4r0IBInf37gSxjM0MFbf0qnzRoxG8NEuCPiI//d2lnUt3BtGyNYiCiPdTtuJ8WP+T5gKmqXpwvFs6WpqXTtaQuxxJEzrkNcErvNe2Z9wBmPzDxCW/ocq+zp+b7KfPBjT2XsILpL9840TaTdpRdTOZZrJsEPK7VN9CCDwa1YIZW3umLLV8yJxiNJBvi9gvS2mp50Oqu4HAuRlqXCw5rBEPo0oxqYOyewYSodLCeD/kOJd+9+sCZeMU+7QkkegBG02x5oHDePf6+EtCqrAdbF/Fwt4lAPZryzs5ARfdbSEaTVM/3REcmgkKBbyFsj8Rmw27jJ7rljvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVkOl8Q/nodkaO6l1rJs0OnFVAPjOYnF9i1CIp+QF50=;
 b=W+bhmWSR1L1H6zF1sDXQn1wWfcDY6jOhDV8bYKf2T7IpLTHkfN98HgV2ZKbZz81dOc33OwUAZQ/S3MpOxo3qN/eswXuHkBO9ZRsdmHbhh2fIcXhLFil3PI/nMfMwQbhVQGVn5KyD1jV7FPaENXkfq+YXlWOciIRG5gFdCd7kzeE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4814.namprd10.prod.outlook.com (2603:10b6:a03:2d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:35:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:35:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 42/48] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Topic: [PATCH v3 42/48] mm/mmap: Introduce init_vma_prep() and
 init_multi_vma_prep()
Thread-Index: AQHZKhw1R6A3SxKRmkKlNz+y36H+LQ==
Date:   Tue, 17 Jan 2023 02:34:22 +0000
Message-ID: <20230117023335.1690727-43-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4814:EE_
x-ms-office365-filtering-correlation-id: 6e40154d-6fe0-4e3f-4509-08daf8336eae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gURo+VjHoQdYiQXh2ZDJ1Kv8CyTxLBVzUXe9PIHlofyNa+mONm9x99cRsI+2/UDSpbVPI9ZJzurS8H507+k5otaTNX+uVIhptiLlv5Y9AxU+lMf+zZ4aSBIoemR7RsuuosERb4iH8twVA6SreSVGVxf7fH63RkXBegRA6e6G7EjEAYtgxeN42pWFrNj8/WYFOx/cgDZ1d7plffrbZK/wszSdDJx5os4AGQQlBiG2SdcIhJlnJUurZ/4EiI3cMkPUwxR1zRNCpxuigWJyrWqCekgj8ahcAhOykiuGRZ0nPtsyrqC1HRKW7FLTnzufb0LXyX0x711jymdgIVt4wARJ+G3VLM0Zs5fuI4UnEVAi3HqBYbMpdtnsQYz67uJbbnmIxcLd6RYP37gBZwVLugPOdRzEJlw3Db+S0X0SBpoD8WPDj8atNUc2QHlqDgrAm8x8mcl82dpiesLRoYvd84bzOVIlJrPRZlwhycz/foOqhJ0AC9X2fneXKWijNBwqXnRIrALIK6HrCrBoCgPRwR25PMQoL6DxArGkx9G7eLE1ijuAEijW43jVhk1YZlw8hNciD5FcvgeEhqzdJBo0l4VJU6EZGG/Err/y3TftumTiqRxwb4166vVvXZtaX6A5ucWRMZ5S2am15/zhVaq6365+IeURfm7sFysL9+ReJHsmg6IQTGrSU42ib7LHbca0kbp7jIm+WMMHUep/W89h4mBuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199015)(6486002)(6512007)(478600001)(186003)(26005)(6666004)(107886003)(71200400001)(6506007)(91956017)(66556008)(66946007)(2616005)(76116006)(66476007)(122000001)(110136005)(316002)(64756008)(8676002)(4326008)(54906003)(66446008)(36756003)(83380400001)(8936002)(41300700001)(1076003)(44832011)(2906002)(38070700005)(38100700002)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SX2E+y4GdCBlaK9S/di3YSPape+VUwEFP6G/1d/78ySbU0Csz1ipz8Plq1?=
 =?iso-8859-1?Q?RAiIINLZjHmRj4lMhl+Vlz5Ifb341E6NJM+YCGbeHhzb9XMB62VmEBITNO?=
 =?iso-8859-1?Q?6sL1C2jYBjxDIFVo37jRv/93Jg6Sd3aHwdEt//3wLYb/jLT4nZs+hrgbRH?=
 =?iso-8859-1?Q?LqYfLpL4mfk34zLicu+f6kY5piNOVCP6G4cZ2xPSxAkvJ+E/ilM7wt74FD?=
 =?iso-8859-1?Q?CmekmvgzG8hbdk/9k6Oyzebvkq1EK2UzKQVGDoiPNpCeUD0LGGA2YJuWai?=
 =?iso-8859-1?Q?ASme8cNZUK6R5upZ3r/Q+Qmgu06ZENLoCtu9IoNPSCeET28qKIn0m30qKF?=
 =?iso-8859-1?Q?IH0OhKzqV9Yl3zbN015o5sEXFdqiWECK0LEcDauZxu1OqmnyCJQ7yPkoE7?=
 =?iso-8859-1?Q?poPLLN8l+zPd0mcaN+PEJJnyoZfLQ0l2QFJMS96/b8tSlsedExlbMrlCIm?=
 =?iso-8859-1?Q?QYYuDl6Dt2lZsSrHtOsDhAj7g7bM2CPZ/Uv061bBYxB2i3Mtee+1VZ4Rsg?=
 =?iso-8859-1?Q?/Qoh2lxmeqLIP5BuU2VPrulPnqeVRqYxG/plqTfvPuIRdHAFrNDdX1/5TV?=
 =?iso-8859-1?Q?U01AhHUusvOr83E+bGBJRULZI2gNye9dg7XVPg6rQUBNy7vMosARu+x2XO?=
 =?iso-8859-1?Q?PC8PFdGTJBo9cz2gpM24ioom1RthAnxEuZMiuDgqaE4f+XPVWtMmWiq4iN?=
 =?iso-8859-1?Q?kyy8Tae2l1il6er5QMRvmSbezMKBOEGr/EOjB7ha3hhDjofYLFEQWi26px?=
 =?iso-8859-1?Q?ihM6OagntHZlwSaC9O7rlkkLDM9w6E9kV+hh/GFQKb7krvOYb/46H5tKTf?=
 =?iso-8859-1?Q?+BNpLxJFNJI8LKSMN/Xm+4odTTtSU2qB+55DF+IL9ckechXaopkb8EMbet?=
 =?iso-8859-1?Q?V8Lb6SX4aCHOaShJiibOjbhplqPKyhRzUyvpxluTIiTScy7o9vRO0vzuNO?=
 =?iso-8859-1?Q?c8GZKEsPtkvkiWtPyQHrYhF9zFdeGJzblJ1VGgw42NUWo0Zh5PMcW5PQC/?=
 =?iso-8859-1?Q?NzN4yf02I8A6ltu0wiPz/8895uuVrtUz1iV8qhnUoYNy4ZvmKniyYXtUrZ?=
 =?iso-8859-1?Q?bXMorz4lEK+dCW1KYzYmEEFhadR++WSsTm49iZiBnndaEa7sDyYjBuuQn6?=
 =?iso-8859-1?Q?lXS91daE/tpxZ1rh/aF2I31z+CMCV0DZiic53urRRDMTcg/NMmxlClT1xG?=
 =?iso-8859-1?Q?zyvApicLIeVSe6eDSObH+fZ8xGj5EBnppx9zIvBBoN3NDzRKQfI0A+Ii5q?=
 =?iso-8859-1?Q?MVZg4JDJFp6qYIWumavrFQEegbui7ULonRf32ZI2S1BS+NyMsK0RSN3pSo?=
 =?iso-8859-1?Q?O0nmZmNGLwrjsX1j92ZxuYAeiTH1hrveBP89Wjcp895rAl9VJL4ia2sSPt?=
 =?iso-8859-1?Q?SY8FfnKMXo0gJWcseG9akiRmVpFvhEjtwPLVYGhTrDHUvlFnQfbD9qQGgT?=
 =?iso-8859-1?Q?xQi3BNJGPV3pK3RGy5Y5TANn0fSxrWIzD8DaGIhroUC/sFJ0NEb03ncdvt?=
 =?iso-8859-1?Q?nBrlOCGZG5MQTrIgB0x8/k2ov0/DW9ENL/IQ3VM6kkcFi7RZz0mLY/c/bE?=
 =?iso-8859-1?Q?09jNbqER5kEtwPXDttenjmjbV/grgsrHvGbHKp8J1cCI6lHumPgrxpurx8?=
 =?iso-8859-1?Q?/XemZyXkLvDcjiSlmt2VCv9bKfZ6LQHvs5tXCLSCsBvGUZVK7sFbITDQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DQI+nS9+O4nH0xtncEpsB9gyT5Y/Vngu5ucsg5p1HbewcQqm82AbRhJk0i+hvDFMX8bbjpX0LOSAuZFqwThxuWay0F3rAtoRzlN0wn6UWO6XKZT513C8XmHc3/PJ0JLBztx8VKxpfnjW/tMUbiWUftn9zcP/W8/sm30F7558lZOEg5aqLR77L0Z0qZUQRUhbuubByg607CUncul7u7q9q7RHMMYCF7aiwSx+Qn79oz7WLUYPVGrlsihTxeztMGc8+I+aa8ksewwcS7vfir5OXbuOKZgRAUDgxOl6Xl+2nAH+tIuSVE6O+FrkJVvA1UyG5KDzdkaijeNs8d8exy009gX3FoDjiPHCqql4WTcdNwhTepFMxTm2QSCFpWNKW0Zo9mN6WJJ2/Rmx+3QMukzb4dx+d4/BIrjQpRmGYPllY/CO7D/QHtW4tdRWHoQjRIdb0o8k5wFfAdpuj90GWVzINbNHhw+PHLakfjXjJ3L4mI1IyGmZ52O9qyOlFeU+HQbFrf3xU5aAhpGPTEMEDdKRsjGXszkD80Q/efU3e4boruY+f/e+T/ZR9bvKJ7GlltJiekIhAhy228HVN8NJlTZ368QiL9+0Eps0OqQS0O5yvbr9s1RWy7h4vTpX/uvcVDO8EH6xNQBaLC7yCESM/8whde7ai7dTtF9ioQeTgSzrBZsQaHihIZpgRZHMngHZbj/6lvJirD6RMzvXm3uL8aS2G5+Rk1dtGKRNOqttF0nwMR2gBDVW1AXK5LHF3wy+UHLIdoGxyORYrG1ezcYKe/FwEJiwP7klSJksrjqYvRhT8N227euXAE1RRLOfLZik9m4PfohvTMnPBOgSglwVLDe1/bngR/2L8HNli1VddJ2n8A8GUA0LGWsZdS209nrQKkbBA1dsUMxf099Kb66wdMnCUA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e40154d-6fe0-4e3f-4509-08daf8336eae
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:22.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqmW/1qj+DOtCQaJ0fRTTkUXzHFyH80NN62tlfj3Fm2bvrMlLpIjlEPHl8mbLre45KfQhCf61bdpVS7huMJPZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: sLGLnv1vxCXTBCnFIKDpkr1zQEqSIR3Z
X-Proofpoint-GUID: sLGLnv1vxCXTBCnFIKDpkr1zQEqSIR3Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add init_vma_prep() and init_multi_vma_prep() to set up the struct
vma_prepare.  This is to abstract the locking when adjusting the VMAs.

Also change __vma_adjust() variable remove_next int in favour of a
pointer to the VMA to remove.  Rename next_next to remove2 since this
better reflects its use.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 108 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2ea7bf439f4f..b28f3416b60a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -460,6 +460,45 @@ static int vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma)
 	return 0;
 }
=20
+/*
+ * init_multi_vma_prep() - Initializer for struct vma_prepare
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ * @next: The next vma if it is to be adjusted
+ * @remove: The first vma to be removed
+ * @remove2: The second vma to be removed
+ */
+static inline void init_multi_vma_prep(struct vma_prepare *vp,
+		struct vm_area_struct *vma, struct vm_area_struct *next,
+		struct vm_area_struct *remove, struct vm_area_struct *remove2)
+{
+	memset(vp, 0, sizeof(struct vma_prepare));
+	vp->vma =3D vma;
+	vp->anon_vma =3D vma->anon_vma;
+	vp->remove =3D remove;
+	vp->remove2 =3D remove2;
+	vp->adj_next =3D next;
+	if (!vp->anon_vma && next)
+		vp->anon_vma =3D next->anon_vma;
+
+	vp->file =3D vma->vm_file;
+	if (vp->file)
+		vp->mapping =3D vma->vm_file->f_mapping;
+
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static inline void init_vma_prep(struct vma_prepare *vp,
+				 struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
+
 /*
  * vma_prepare() - Helper function for handling locking VMAs prior to alte=
ring
  * @vp: The initialized vma_prepare struct
@@ -569,7 +608,7 @@ static inline void vma_complete(struct vma_prepare *vp,
=20
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we must remove next_next too.
+		 * we must remove the one after next as well.
 		 */
 		if (vp->remove2) {
 			vp->remove =3D vp->remove2;
@@ -603,17 +642,14 @@ inline int vma_expand(struct vma_iterator *vmi, struc=
t vm_area_struct *vma,
 		      struct vm_area_struct *next)
=20
 {
+	bool remove_next =3D false;
 	struct vma_prepare vp;
=20
-	memset(&vp, 0, sizeof(vp));
-	vp.vma =3D vma;
-	vp.anon_vma =3D vma->anon_vma;
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
-		vp.remove =3D next;
+		remove_next =3D true;
 		if (next->anon_vma && !vma->anon_vma) {
 			int error;
=20
-			vp.anon_vma =3D next->anon_vma;
 			vma->anon_vma =3D next->anon_vma;
 			error =3D anon_vma_clone(vma, next);
 			if (error)
@@ -621,6 +657,7 @@ inline int vma_expand(struct vma_iterator *vmi, struct =
vm_area_struct *vma,
 		}
 	}
=20
+	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
 		  next !=3D vma && end > next->vm_start);
@@ -631,11 +668,6 @@ inline int vma_expand(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
 		goto nomem;
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
-
-	vp.file =3D vma->vm_file;
-	if (vp.file)
-		vp.mapping =3D vp.file->f_mapping;
-
 	/* VMA iterator points to previous, so set to start if necessary */
 	if (vma_iter_addr(vmi) !=3D start)
 		vma_iter_set(vmi, start);
@@ -666,14 +698,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	struct vm_area_struct *insert, struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next_next =3D NULL;	/* uninit var warning */
+	struct vm_area_struct *remove2 =3D NULL;
+	struct vm_area_struct *remove =3D NULL;
 	struct vm_area_struct *next =3D find_vma(mm, vma->vm_end);
 	struct vm_area_struct *orig_vma =3D vma;
-	struct anon_vma *anon_vma =3D NULL;
 	struct file *file =3D vma->vm_file;
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
-	int remove_next =3D 0;
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
 	struct vma_prepare vma_prep;
=20
@@ -692,25 +723,24 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 				 */
 				VM_WARN_ON(end !=3D next->vm_end);
 				/*
-				 * remove_next =3D=3D 3 means we're
-				 * removing "vma" and that to do so we
+				 * we're removing "vma" and that to do so we
 				 * swapped "vma" and "next".
 				 */
-				remove_next =3D 3;
 				VM_WARN_ON(file !=3D next->vm_file);
 				swap(vma, next);
+				remove =3D next;
 			} else {
 				VM_WARN_ON(expand !=3D vma);
 				/*
-				 * case 1, 6, 7, remove_next =3D=3D 2 is case 6,
-				 * remove_next =3D=3D 1 is case 1 or 7.
+				 * case 1, 6, 7, remove next.
+				 * case 6 also removes the one beyond next
 				 */
-				remove_next =3D 1 + (end > next->vm_end);
-				if (remove_next =3D=3D 2)
-					next_next =3D find_vma(mm, next->vm_end);
+				remove =3D next;
+				if (end > next->vm_end)
+					remove2 =3D find_vma(mm, next->vm_end);
=20
-				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next_next->vm_end);
+				VM_WARN_ON(remove2 !=3D NULL &&
+					   end !=3D remove2->vm_end);
 			}
=20
 			exporter =3D next;
@@ -720,8 +750,8 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_ar=
ea_struct *vma,
 			 * If next doesn't have anon_vma, import from vma after
 			 * next, if the vma overlaps with it.
 			 */
-			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next_next;
+			if (remove2 !=3D NULL && !next->anon_vma)
+				exporter =3D remove2;
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -762,30 +792,14 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_=
area_struct *vma,
 	if (vma_iter_prealloc(vmi, vma))
 		return -ENOMEM;
=20
-	anon_vma =3D vma->anon_vma;
-	if (!anon_vma && adjust_next)
-		anon_vma =3D next->anon_vma;
-
-	if (anon_vma)
-		VM_WARN_ON(adjust_next && next->anon_vma &&
-			   anon_vma !=3D next->anon_vma);
-
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
-	memset(&vma_prep, 0, sizeof(vma_prep));
-	vma_prep.vma =3D vma;
-	vma_prep.anon_vma =3D anon_vma;
-	vma_prep.file =3D file;
-	if (adjust_next)
-		vma_prep.adj_next =3D next;
-	if (file)
-		vma_prep.mapping =3D file->f_mapping;
-	vma_prep.insert =3D insert;
-	if (remove_next) {
-		vma_prep.remove =3D next;
-		vma_prep.remove2 =3D next_next;
-	}
+	init_multi_vma_prep(&vma_prep, vma, adjust_next ? next : NULL, remove,
+			    remove2);
+	VM_WARN_ON(vma_prep.anon_vma && adjust_next && next->anon_vma &&
+		   vma_prep.anon_vma !=3D next->anon_vma);
=20
+	vma_prep.insert =3D insert;
 	vma_prepare(&vma_prep);
=20
 	if (start !=3D vma->vm_start) {
--=20
2.35.1
