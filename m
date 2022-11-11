Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A4A625ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiKKNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiKKNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:00:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911AC3F067;
        Fri, 11 Nov 2022 05:00:06 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2ABCAF7t012952;
        Fri, 11 Nov 2022 13:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dEUwqWDMJHr6G6XY0tzdAf8PwS50KhhgaSiQ0wwz/2s=;
 b=S0BBG8vLfxa/qpiI6xIf2yUCavnSTqemgoRx1ARh1nyY6MAwxg/Hq+AduaheNID/wrW+
 lJlYTzFQt70j9ia37YQrjWmIN/f+72bQvKLfwcx2NpO1uQfFfeCN3s0dcGFLoU1U4QU6
 2+JLDjjsVsdsZ8srAOF9+ZH8nvgGU6pGTE0mFjUZk2H3psW5eg6TOqwtcivKvo4MuNQo
 VlpO8SUIP7f2GDNT36HLQDnHy0TjEk987xutb8uLV1P6FOxXll6phY8PRtW5HNTOJQ+7
 vxgq87wKwCbPqqTafGjLywlHGV/zQwsBPMIsk6M0pFYdaBP8DzR2/xnH1BraVUIFqY/U Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksnkt1xgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:00:06 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ABCoPTe020970;
        Fri, 11 Nov 2022 13:00:05 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ksnkt1xe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:00:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ABCqTvD024946;
        Fri, 11 Nov 2022 13:00:03 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqggrjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 13:00:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ABCxxLF34406768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Nov 2022 12:59:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C89DB52050;
        Fri, 11 Nov 2022 12:59:59 +0000 (GMT)
Received: from [9.171.11.51] (unknown [9.171.11.51])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 65B4E5204F;
        Fri, 11 Nov 2022 12:59:59 +0000 (GMT)
Message-ID: <7b57f8ee-b296-06e4-75e2-cef8eb018719@linux.ibm.com>
Date:   Fri, 11 Nov 2022 13:59:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH][next] s390/dasd: Fix spelling mistake "Ivalid" ->
 "Invalid"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220923132103.2486724-1-colin.i.king@gmail.com>
From:   Stefan Haberland <sth@linux.ibm.com>
In-Reply-To: <20220923132103.2486724-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VBfY4wbMSIGYagy3cerF2HKmO_tJC0wL
X-Proofpoint-ORIG-GUID: E7gBr_Z6DsQJP6qeFv6SApj5Fj38B3ge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=799 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.09.22 um 15:21 schrieb Colin Ian King:
> There is a spelling mistake in a pr_warn message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

applied, thanks

