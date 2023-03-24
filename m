Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454466C874B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjCXVHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCXVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:07:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD2166E7;
        Fri, 24 Mar 2023 14:07:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OL4NCM006418;
        Fri, 24 Mar 2023 21:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=sMrWGF4iDvga1gtu6cL78e0EHnW0GNkp2SZd9j0LaBs=;
 b=g1ZztP07jh3xUNoImnCeix3zgWt8GsKG4pQJkGUQpwf3JPvqhKN/LYFfNkDPMts+dH6P
 YAhXs9uPYAtfsn3OgSmPdQpQkR3Jnm5ewCm2xs0xZxlB9XyOGu4S7fjmB6SFraIiGrmi
 94NuYni5B80XhAVI3jCfzre1D20ZhnbUuN0P6gtO38cuYh9bk1NI9TixJ3BHAimzL5AG
 CT2bcMrrz8CWdMxPUpv1eIurcIhPE7+bUr0hFn6LAVolIORbPWYDcHWNMG1SI9LvK8pZ
 9Usn/NtHX50meZEBQZQUTJRAfGoQXHqTnZV0vxI1McwkDH9Konnk/NZpd4TVbNwspZq6 cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phkey806u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OK211W027702;
        Fri, 24 Mar 2023 21:07:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4se43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 21:07:08 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OL76f8017159;
        Fri, 24 Mar 2023 21:07:07 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4se2p-4;
        Fri, 24 Mar 2023 21:07:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-scsi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/3] ufs: qcom: add __maybe_unused to OF ID table
Date:   Fri, 24 Mar 2023 17:06:55 -0400
Message-Id: <167969123974.59527.7651458809202499839.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
References: <20230310214435.275127-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=968 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240160
X-Proofpoint-GUID: o6Q1LuRX7_Loq37EO1y-dSGVQxwj9H6R
X-Proofpoint-ORIG-GUID: o6Q1LuRX7_Loq37EO1y-dSGVQxwj9H6R
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 22:44:33 +0100, Krzysztof Kozlowski wrote:

> The driver can be built on ACPI and its .of_match_table uses
> of_match_ptr(), thus annotate the actual table as maybe unused.
> 
> 

Applied to 6.4/scsi-queue, thanks!

[1/3] ufs: qcom: add __maybe_unused to OF ID table
      https://git.kernel.org/mkp/scsi/c/dd3f53301181
[2/3] ufs: exynos: drop of_match_ptr for ID table
      https://git.kernel.org/mkp/scsi/c/cd6a6893ac05
[3/3] ufs: hisi: drop of_match_ptr for ID table
      https://git.kernel.org/mkp/scsi/c/d43250ed0fec

-- 
Martin K. Petersen	Oracle Linux Engineering
