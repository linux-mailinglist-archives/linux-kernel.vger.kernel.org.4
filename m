Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15736C331C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCUNlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjCUNlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:41:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B50E2B2A9;
        Tue, 21 Mar 2023 06:41:48 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LCvA0d019777;
        Tue, 21 Mar 2023 13:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=4q4V9pKFRmav1C/VEmrxumixzXGkJGPO05IUdd6LylU=;
 b=mwbp3W63qxJm8BusVOZQAkO67cAeC9sUuXmz7Rhhyl7T0MwaW5U69uJj6Fp+UDTZK+vK
 C/YjjvGxqELR26H9J50SaDhX5pf76k0vxk4g37JEyqJs21tRVHhrwp7NLuKFb3MMSNH5
 f1m6l2bZp2FT3N4cT9MdehI2LJ5U6lKUQJmqqt97KwrCkFhXRcvp84eKIg9zq78p9pcE
 y9sy3My40xYbs33JF3ZdA1hHcQVH+DHCyaZwFPJVjWsexHAolBorpdgD7YQpshw7GI0Z
 PsXIuDdM3+Np5GGEVykDlmR+KghpikOi/G8PMLmUJcpMoiBUBZvXoSOYT18GNvdk7+eq yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf923y6nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32LDf2lt008562;
        Tue, 21 Mar 2023 13:41:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf923y6na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32L8rZHh015074;
        Tue, 21 Mar 2023 13:41:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3pd4jfcqhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 13:41:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LDfdMd10486402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 13:41:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6540E20043;
        Tue, 21 Mar 2023 13:41:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FDFC20040;
        Tue, 21 Mar 2023 13:41:39 +0000 (GMT)
Received: from osiris (unknown [9.152.212.90])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 13:41:39 +0000 (GMT)
Date:   Tue, 21 Mar 2023 14:41:38 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com
Subject: Re: [PATCH v2] s390/vfio_ap: fix memory leak in vfio_ap device driver
Message-ID: <ZBm0EvrdTNlnG4sP@osiris>
References: <20230320150447.34557-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320150447.34557-1-akrowiak@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1Iez1UE928StuEcbYqMTPsih_PoGkuoH
X-Proofpoint-ORIG-GUID: TDmUH5d8ryujrFaazABNJw_AquiaaK0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_08,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=816
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:04:47AM -0400, Tony Krowiak wrote:
> The device release callback function invoked to release the matrix device
> uses the dev_get_drvdata(device *dev) function to retrieve the
> pointer to the vfio_matrix_dev object in order to free its storage. The
> problem is, this object is not stored as drvdata with the device; since the
> kfree function will accept a NULL pointer, the memory for the
> vfio_matrix_dev object is never freed.
> 
> Since the device being released is contained within the vfio_matrix_dev
> object, the container_of macro will be used to retrieve its pointer.
> 
> Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied.
