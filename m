Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFECB609A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJXGgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiJXGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:35:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A9CE22
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:35:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O2eWwO025813;
        Mon, 24 Oct 2022 06:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=RJNT3cv138idUGAC1vIxk/Tsbjq3yR7Z0NG3O7ydz9w=;
 b=WE6WD1FKZYjcGEoKGgR9UnhJpXs4yvyuPD3CZ7R/ocuOP7adnlhhX0cI5i9eUIDU8aFg
 /T+tODiaXYUxHlIWfIlPDLzw8VAnTvNE4hbi/BrLOiH0zin1I3zztKJfVFbJt9wxkO4Q
 22id8uvynsDC8AcNuMlxyN++WY4WbLAVymwM2qQ+YxCMPBRjjlFBpvIp6G4Rb9g/cGdz
 hDR6UBVQtm7WuduBxoO/W7nOjHco6s3oeprIH1CLnHEhbQToFU3/s2gx6baE67BRsB51
 c/K5UlAHPwpKo5JFJgvZCPoWOJhKQKvbcEGfbBWz9p+MhB5pK4tF3bFeyOQVNIYokznQ Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc6xdts0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 06:35:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29O4Xl45030718;
        Mon, 24 Oct 2022 06:35:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y3cy2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 06:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mODjQMond/kt/UU+3qN07mm2oQUoeIBb8ellXlPhMP3ymudTOJkdHcrUj/4YstXBHtNG/qc/ZSqv4+5nQTEm0duh4+S3XOImf3OfLgIaOmCShDHZ97yjcAuM+Fkvl2V/+BF1SwBsGto4/lKGfyG7f9N0UR68yBMby/kecI3KpSZbDSdi8/hHWJzewAyvUvib0I+I1L3jw8MMniUuQ4cY7UyBdX1VZOtry6HI+JrNEq36LJnw45TslaxSTcwJdm3jwUu/u2/5LsS68IOcqn5yFhmKdbQFeH9MmX8ni3DaxaBxALXUXugJpmLjchNLyvhLCbHZr3URnJtIowleGPJEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJNT3cv138idUGAC1vIxk/Tsbjq3yR7Z0NG3O7ydz9w=;
 b=k5Zx++RNZEtjrEwdbyYPIxS0pZmP04weYNYFD4rygh29cBXBzJ5QwO/Io1C+kBFBgDRkhBLw6yZXqQhVIflIb9iR8XjbIA1lO7LZqMYl5mXGw2Mxhn/s5CblQaSxquolA6xGpQQEw1PkFJiXtS/p3siGRZtm7t5hB5BGBzEp74e8G2Yw2so+lhNt3CGl3Ffwrcv/LeI+PIY3q45kkCZkidinyBR7hhHN4j3kOW0QGPr7M5ZgmDOsQf3TM8CNZZ7SEzC5UyyVl6aetOLyeygOLYUFPF454TO6eZgoH/+hSsUEfk/lX7FOUifZBCyQD1I2OUO4y2e4hSxGlvRdB42SHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJNT3cv138idUGAC1vIxk/Tsbjq3yR7Z0NG3O7ydz9w=;
 b=jAgTZhY+vMzM/RfzcCw+pJitEaXi0BPObrO2pAKYROC4lSEHXHcOzLOaRlQ6TbRqBluRS5YXa36eAkUjoCyhAXoINQaJ+BzMBpyE1oW4MLD3sdprClScwMZnjg+kwUipSj0qOxkmDFffT7N8BMVKUdrqCwEqXTJJ751rAAMGIEU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by PH0PR10MB4743.namprd10.prod.outlook.com
 (2603:10b6:510:3e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 24 Oct
 2022 06:35:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 24 Oct 2022
 06:35:40 +0000
Date:   Mon, 24 Oct 2022 09:35:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: r8188eu: remove unnecessary variable in
 rtw_recv
Message-ID: <Y1YyK7YYshq1nayg@kadam>
References: <20221023200532.259276-1-tegongkang@gmail.com>
 <20221023200532.259276-3-tegongkang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023200532.259276-3-tegongkang@gmail.com>
X-ClientProxiedBy: JNAP275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|PH0PR10MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e59966-b62f-4e25-caf6-08dab589f801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7l1ArgMqM3BCHZ/Pp8CVvGI8W85lWxkiWW4E2NF9fBdS+wS8HVcaCYszjLtsfbQ5JyJaikepK3tc4XaUIQrACwSe0eTmgZWprcKFkiafCmxML8MRp6vPVFJP1Q2GnQTaJuPwpIqjSr2BzonysFioyo6XUGJBCtmJdm6hdCn38rT/aL2LbFpSe4RgoYEsvxAciVxPAWC+M9ZXWmNgyjP+9XtUrzx5jNk6Ux0NHHoyrlweJ3Eu0X3Kixm2b2C1TQYOmul7KSgQsi1Xxakw6Yzta7GZnxQ5FXOuEYdfOI6zZ/EIp6XFaT4/zQA2c66ZuCy/A6uP6JJTL6lGWm6zTimQMb0aEJ/7Ues3XxFi06t+s8sJ8hNjTYchWZLw53ebIo1bN2oiKMBc1D0O1YDVJwt/yl9p7t9eUj0Jz3uyscuXtaunMIECwLPOeT44ysq+LqD11pPmtrNDa14B+uH73V3CxgFrixEGsXZ9uRa8GZDO21lUVr9Ncnn2y6TnRuZyFIpS3VnG6gppdAp/6gLr8jwFA7tNVIrXt+21Ox6PSEF43G+qnCJwtRiQ9ELCGn3T5T3Y/wmFzuzLBC/hK3xzeQ1C6NWJiDc7kGgX3uNv+tuUuQWu/KD/g8GZKgnJMNt7XqPItDQ937O9SkTKL9uIr5IDtn3qKFfQ9JpAIc/uYKVfPG+B8woYolWb+Ixy06WTFchOmQObneUt63bj/RAYjKmSvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(6486002)(41300700001)(9686003)(83380400001)(4744005)(186003)(86362001)(5660300002)(44832011)(2906002)(8676002)(8936002)(66556008)(6916009)(316002)(6506007)(6666004)(66946007)(6512007)(4326008)(26005)(38100700002)(33716001)(66476007)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ANfy5htSHUt4n9ZaJ4XhKsVjJ7+CGCMgLI06a1cpaQ4W47/IMqOwSJoiSsN?=
 =?us-ascii?Q?xyHgKHNArkQXZU49bAFH3/ihrFdwaNF6okmAfIkkL+PO5MZkBvxmpGlEZSTS?=
 =?us-ascii?Q?a8uc1xzOa+hoZBTTDaf2IGF1Ma7Oke3PCPXPeCpqFCJ0CUVRksdCWlbzyOYy?=
 =?us-ascii?Q?nqIuEXkE2ysRmsGV/WP73PSnv3aLgf0DEErDCr2oDF2X22/mVQWHRCqbRIbk?=
 =?us-ascii?Q?6RBX4OaMzNZTtAE2fYrayoPJJv0VcZBK1LaDMK74JUWlikwbtEzpoMlKGKuE?=
 =?us-ascii?Q?1Z3FzneCZjbpzEs/hqVTi6KW1S9JefSRkoV2oBBzVwv+TdMsQ4CzeYCJqpxm?=
 =?us-ascii?Q?2Q1qFYOIPaIFSOAbwWWb9TWPf3WEhjcXDkEL9n8OiIB7d4GxcphMvvzb3VRM?=
 =?us-ascii?Q?h6aX+ZlNOg+HAlY2DgStz/iF3c8aAgbN6w1BMLzhXPHKpYN+JkE8lcAgdX8Q?=
 =?us-ascii?Q?OZhH8qDcSyIs6Nir6mnXOGIWWgqo0qlE5dvZBAzfwxL6bNyBIoWmY+RwVmMi?=
 =?us-ascii?Q?H1DDnpKpEGPWLYR1ZKs0UDLad7vvKoXgg029Z3lu/3fpaIrW9/iV/FTx7+U3?=
 =?us-ascii?Q?i6LKFaKig5oTMv3bkvbDGj9ikzOFeTRp21O0ITKm5SxzgpLKEAfUm/5TCtmT?=
 =?us-ascii?Q?nl5bY5UUS6Wp6OEhQlW/72rpdeJ4LWaaQ+ATQCxWQhvkJ9uPLOrJXZiW09xN?=
 =?us-ascii?Q?eo+JwtDInhI7aQFhmoMiVk4WNPmcJGOLWiawT9IPbjK6CWF+l6ec4FRloXgU?=
 =?us-ascii?Q?GbVWJk9fXcP7mgN4HnxdDnBGJu1K/AJLzmxDHbFeLSdpjgCIeeAszH+CQCnf?=
 =?us-ascii?Q?6awFhxwHqglN2FF/AKnVsGMa7Q4Tnt2ln0rjdFTU5sWyM3N1vyNRfG7IfulV?=
 =?us-ascii?Q?tzvZOCjzFirx47OjKROxeRBmQtQQgoTu/nr1P7eFR4FpCKpI+5MjDoLOcXjO?=
 =?us-ascii?Q?l9NDElR6OFd1PkkXT7fRLKLPHAZ6StvUmPdsVQONiSEsf89tyCzWO2N91iGs?=
 =?us-ascii?Q?lWKhT9pVcZ7fFAggvSk+v8mZy5ShQPrYsUeDG8USer75aKoLbmerYl2K0jUE?=
 =?us-ascii?Q?lZpYm8xKLXkgsdQlcSOqoXCv1pmmryrzXUsmXdiaM2k1WjNC2UNOyTVN98o4?=
 =?us-ascii?Q?qy1t3ylysGs43XiZsJ2slHkMBA3F6SA9p98apypL/nRksiqT1W1Um+iiFgx+?=
 =?us-ascii?Q?ODME5M9/MA/3R7t/lK1DamzpqRga6capNHUtOEimH5NArN+l4SDATP36zhSE?=
 =?us-ascii?Q?mSxGoSU71smVnQH+FGhSROG90x7D0oFspIU1iUs9+bjhb/ALWO7ikH74M58M?=
 =?us-ascii?Q?am5N/aIN3xWyYraomREI4kMgjIUMscYIm4XRUDSIqLql991qwGNmRzf3E9oD?=
 =?us-ascii?Q?wWEIW1rmUBkRJsRiW7oIIvaGGsl3VMs3uWkwo5Ba+K9RBcnAQbdu1xGiQZbL?=
 =?us-ascii?Q?j2cG89LtrGwyk6fDx3ixbS/pFs2gG10dbeqbg/wleOnxfCRvgaR3ieFHtPcw?=
 =?us-ascii?Q?JSnbgWnws4DuVaDoiaksf9FObTXf537/XtvIKQXCLoI1g60N9TxhdKpfzweW?=
 =?us-ascii?Q?G6zrSXKI8W2sblK1u+7IZg5nmkytwnecYxDIFWm029v2PrRrDiG2mkH0sV4C?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e59966-b62f-4e25-caf6-08dab589f801
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 06:35:40.6266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cRszhfbxBPA+l4NbMkiqk+BBErjNAEBwY/qDGnOPQ5QzwEWvG/G3ssJTm+HPk9iKPiiwzxjg+Fadiv5i7DxZYQmawovA67S4feUiu4Sih0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-23_02,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=853 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240041
X-Proofpoint-GUID: peFmB1J0TEnIjNo7ENyhiAE8aba4JK_2
X-Proofpoint-ORIG-GUID: peFmB1J0TEnIjNo7ENyhiAE8aba4JK_2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:05:30AM +0900, Kang Minchul wrote:
> Return _SUCCESS directly instead of storing it in a variable.
> This can prevent cocci warning as follows:
> 
>   Unneeded variable: "ret". Return "_SUCCESS" on line 1516
> 
> Signed-off-by: Kang Minchul <tegongkang@gmail.com>

Make the function void instead.

regards,
dan carpenter

