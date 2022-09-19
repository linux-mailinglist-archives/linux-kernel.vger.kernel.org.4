Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B705BC5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiISJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiISJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:46:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E582655F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:45:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J9E9UW026301;
        Mon, 19 Sep 2022 09:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=m00gCmLH/ZHlj1wwBO+cLAL5QEJAZG5zha/aecXzKjs=;
 b=Y13N+DQiLiqMJRsAEqbg5rb1PPDaZhDB4NB3dvdRyZVhSJ5y0fcdCKaYmWjhuXqG/4ug
 67v11gKDvB23qPPaSab8UncSAHYiLgif7NkC62i30bxslJfbn4aaoWzwwztnEK33o5u+
 Aze7B/1alXofmfOmSC6JeQ98psNyi+Qfs1b1WwdWL3baMiNBeOub3x4NLpMoo+cALB3I
 gT4EWVCd6CFpHDBeOLcePkEM0iDF7SVrrMrHUpm6/ZdIDagNV3ROTbrHcpgHfTYuZas3
 /yykQywVXdGPv0C3gpW4BA5soDVQdZm4sgPfi+JUgauxc14cl2En9BJCkjM8yDUxxCCO HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kka01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:45:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J76n1v035914;
        Mon, 19 Sep 2022 09:45:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39hm8rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 09:45:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZdHxC9vZcVsdOfoazRWJUyxprqztYrK72WRRfsQIBh1PRqmyYEuT7akNYsCm1iU8hxOwWWPHS3MbMSuX9aV7Y6jWVFaHrgp9n2EsJlR/21QJUkADqZSqKyx3d7FDOr2z3gbLOL+pgDU+dFS6Bh52czGXfntSuRH7wbeUdFZNSxmQc90hKri8TqKuaICtimw+9bW4yIRJ9lgnh0PgwFU+X7f4oGOcNA3p/vSUSBa83bTY+Ghg1D0QCqmZHNIryDxzi/kGg5a75bccUYn+3p63K/d1uZta5KG5Jl7i+kf+Jo3cjOhh+5B2sMhRIisHLBnlGtdIA+CRNV544vLT+nNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m00gCmLH/ZHlj1wwBO+cLAL5QEJAZG5zha/aecXzKjs=;
 b=aZ1ZDa/MQydXNDF6i1U8X3mnEJNOhmiWIQgUqehEYhuctrSIKrrQ0Up5BmJDtzBeKtXHx2mJQsTwmqVAqdYnyP4ebQRQ58jooD8ARamY5SWSTCuCpiRQhOt1lcxoC8iDBbTy63mzUTPnCElG9yPKXpXBIlGo1v0mfUw3pPEGn0HYTeyO1bZdI6WOyGpP4J5zVLN4Y0uyBo1oRIipGp7xVnkr0UoU12i+K1wylx2AKss0fvT5X3gZ+UZJh9Dhzq+QGwHwmIglv4sBbXNCxLZyrp9Iye7wmLqna6z/Utk/B8ZmhMSWUo3TkDqrjHkgLJ7DBMoacEqvgFpXcZYFrch5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m00gCmLH/ZHlj1wwBO+cLAL5QEJAZG5zha/aecXzKjs=;
 b=aP/XZvq4Ln9gs5bcLSQ3XDySygh41ga75sLTjKvB+2ybJODJojxS05CMiEBRq+NrfF7FTeAIPuDQgiGq7hn+4u8Q+IlRNpa1HUPvuugI5m5/O5KALxk44z2fjVHhP8lLBVfQCJbOlBikjiuvgCjx9rCRWtsKH2dXUOka7hWc9qY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB4845.namprd10.prod.outlook.com
 (2603:10b6:5:38e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 09:45:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 09:45:35 +0000
Date:   Mon, 19 Sep 2022 12:45:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        philipp.g.hortmann@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 2/5] staging: vt6655: change vnt_receive_frame return
 type to void
Message-ID: <Yyg6J/u23jcB2v+n@kadam>
References: <cover.1663273218.git.namcaov@gmail.com>
 <f727ea04703858920f6da694676ec323469e7b97.1663273218.git.namcaov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f727ea04703858920f6da694676ec323469e7b97.1663273218.git.namcaov@gmail.com>
X-ClientProxiedBy: MR1P264CA0090.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::14) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS7PR10MB4845:EE_
X-MS-Office365-Filtering-Correlation-Id: 5871072d-ce98-43dd-c342-08da9a23b392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Luy368hSZg/lMML3kOx8Vi6uKI4m/3WoWNwgfz2BZmW8bAZd7icEt8RVpELab4Hiod6+/v4EapyguDPB0bJNpyHeqdyQJZicbPkQARzfD8MVUcm5SCN4M/NRQRfEPqvoKcyiMomYrU0TBPB04HNwO4z0XJmrOduGsOX8PI/jeXqiSOSjGIsYXYFC6yofGVr3scx4jdiQtHt+dt8aDJ4KXAv6/i+Gjww1IyOCuGLId65vELadlULt8tzv4W2WKhynZZ5tgfzn2MCy0ob1JPD541yYheZXW2Ls96sNVL3p7X+NeGSV9BeWfDZYW8VyEd2DSLUcXyX5IfmMTgqh33D2mB7Bck/I/DziXUrJj/rdUYhXxToW9a2fC04gLaFql5jvkFlmrgsjXIUm/zl4jttwstwkPhgvCWXGWWj8Ww9EHcIF4JnfL1Vfxmz1dCgQg4kBeT1MIDdps4sRoZznPcPc+fP8yVrAb3MizLra9pMc/z/bimUylM9cTWQnLWqODrjyuaINVU3QOnPcpIiywkvxxgoC8dK8hdurUYTobqm6EdGTbIxht2kfIhzgU0V/Pnzw1AdCz+OIDF2urKkwskI9w8mJR7ninQFDHE+cEzpxSHKB3g4mjkNv8gRtxAZv698VIFUpqBgyn9ZBdC0Odt2ecvXAqfIkRMbCwyGSVY/V9vvILceJ9adTu0TzSiRKah5h5hagX+zE0J249hTtt0/Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(6506007)(4326008)(2906002)(86362001)(38100700002)(8936002)(9686003)(6512007)(6486002)(26005)(66476007)(8676002)(66946007)(41300700001)(6666004)(478600001)(83380400001)(66556008)(186003)(5660300002)(6916009)(316002)(33716001)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ww13cQ54KiVddjwKL8qUZqBeyZjGEbv+MK+BHYBPxcP7P2YDEgjtvQCFGkfH?=
 =?us-ascii?Q?MqG9/ebCMTe+yace79Swlhyx68Ildpb67AmXaf48Y3nnvZTX8cq55nFWgky4?=
 =?us-ascii?Q?LYAO0sota1AWIU8/EfFkFGG+5fH5rlVEOTneoN3HPMhUlQvqQzHAhRDnHMtg?=
 =?us-ascii?Q?8CGsx5p5FUtlyAQpA8UJk2UOVuJxV/RNiWfywJvwjiWUHgVnP3JeCXSeFPIU?=
 =?us-ascii?Q?Be0XFJtYJlqKRLslAEPkKj9QUJGHsypDYshr04xBr+ORvIOQ5V6+w64ecRrC?=
 =?us-ascii?Q?dsuW3rjV6FkuEZ8CvF81ha6tUy6ZIQJteB1KegIF2Mm8njCucWpTRN4sAzIQ?=
 =?us-ascii?Q?bkr6nXHccBYa/Xnj9C12IFVTNBi06JcOnH6q12whDJW5J/u9oebKFJK0n4TR?=
 =?us-ascii?Q?lIJ1oYolvI7Urk3Zl74aVNDPKmj0Sd+T6kMC9Z2FZOGlVp1XyMtdDoM1at4D?=
 =?us-ascii?Q?wtCR4Kg5KhrccuIMxne0gaf92VBOPt5xyxCPxANBpu/Gfv/uNiaOLNcviSVO?=
 =?us-ascii?Q?5jFKqlJUuctRjzFq2D6fp6M8EREaZTINM0G0AvPXszQSiMwpW+LlysM+nwgB?=
 =?us-ascii?Q?qsBCB+qdW9mqElrt6YcdKZQ7f41Y0MSaRfmomhQdjMmZO5Ux1o1QqLj85bJs?=
 =?us-ascii?Q?euQY51xMo1MG8xdELbzXHFaAzYDECzWy1b9QPJuQ775a/uTPOFUuyhJc01KY?=
 =?us-ascii?Q?v9D8IyLINYdca3Zw0VJtF7PnH5+W2pkm15UPVc/PNm/23PFv0uoaSZafPpv+?=
 =?us-ascii?Q?JSVfKK0Hg8PD7rEi4anaYJjWxSJtYquN5d3rKQH4+Ftxk9GJjp2rwi6Ltb9n?=
 =?us-ascii?Q?sKErTm7qY8Te0O2YgFnQtIruZb+EqHS890MMgAeer2krxEtmF67mqX99QZFu?=
 =?us-ascii?Q?swiHES+A2O9F/upxBp+V1zaBSs9x/eRjkw61X/1PHeDlwqMF1avgPPVEdJz3?=
 =?us-ascii?Q?hOpPdKPG1iyi7NjBe6yYrbwuv2c0MjNq9cPSllWY3o/2RV2wynjOkS9cpsP2?=
 =?us-ascii?Q?37QJtYHGN99ALQuh4Bfebnhd49TSyX4+Nc0hbAAxRKMYkeUx2bL6RY7/jksY?=
 =?us-ascii?Q?WcaYi92peaNy5OEP/SYuDa+cXWiYAMSrgdeaCG569RzTAJDKi2amGIsZFtzw?=
 =?us-ascii?Q?84E3rtSVHBkSOixXXCHOkhNVQPq2ZH3FhUPfMcqMnvCDAusWDoxmBkwl05UG?=
 =?us-ascii?Q?MH2R8xo5T9VkB5mi9x2wMA7cZmHeWzoWE7veec6K7d26aEtP+U5+Lfxi6Ckj?=
 =?us-ascii?Q?RzUbyC8mFfw2ugr2ugproyoM9C0E/5D6sIM4vtEKmvoksP3uftnNtGZDD3cr?=
 =?us-ascii?Q?d/GdDvXNJuIx6LgGiTvFXu4jv0E6I000OX8sKtmvSQBN+JUOK52wDFGor/0l?=
 =?us-ascii?Q?qXrKYFu4L/ySHgWcFuzcNvmcdaGsw92Jv5MuSqRHDitJ0W7Oj3+opirX3qL2?=
 =?us-ascii?Q?3fFV9flKIlawwqfRvvbVm1rKd25pFAaG9dJ2ek3rVVZoLnDWixlW9FSqk5MC?=
 =?us-ascii?Q?F8cR1dI1i5OzU7Ag/bgtee2ITs16NAKRGF/HdkkS7UvNSGsMKwjMBE+AdX8n?=
 =?us-ascii?Q?JqNua9Z2ydJqK3gciW4Mb2TpjanWHanHjRneoUvKmRaGv0Ga+NVpsh228g1E?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5871072d-ce98-43dd-c342-08da9a23b392
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 09:45:35.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8DxJjxkmc15rkgBJuI2dUL3EjKDezVt1v2CoRPtixDIjzQHSaKUHUpPrvWlCy9lWQxcaLJYB4YoYpKZnGvRxWPLH3Py468HFPKVWglfIoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209190065
X-Proofpoint-ORIG-GUID: jaD2DVi4uSFt5sp9dD72Psd5_c9FBZeg
X-Proofpoint-GUID: jaD2DVi4uSFt5sp9dD72Psd5_c9FBZeg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:29:33PM +0200, Nam Cao wrote:
> -bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
> +void vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
>  {
>  	struct vnt_rd_info *rd_info = curr_rd->rd_info;
>  	struct sk_buff *skb;
> @@ -133,13 +133,13 @@ bool vnt_receive_frame(struct vnt_private *priv, struct vnt_rx_desc *curr_rd)
>  		/* Frame Size error drop this packet.*/
>  		dev_dbg(&priv->pcid->dev, "Wrong frame size %d\n", frame_size);
>  		dev_kfree_skb_irq(skb);
> -		return true;
> +		return;
>  	}
>  
>  	if (vnt_rx_data(priv, skb, frame_size))
> -		return true;
> +		return;
>  
>  	dev_kfree_skb_irq(skb);
>  
> -	return true;
> +	return;

Just delete this last return (it's pointless now).

>  }

regards,
dan carpenter

