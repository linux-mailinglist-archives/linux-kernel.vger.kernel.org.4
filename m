Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE02622403
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKIGiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIGiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:38:12 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D30C1A05C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 22:38:11 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A95QeDH008034;
        Wed, 9 Nov 2022 06:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3+LWY7rOfZY5YRaRctYvHIq2Smel5cZR6qlqZRITIEA=;
 b=DqCYsqQRYiiITVG7TXe41v+sdWeGH8DXQ7XBVo2uwUMxoaMowvXB1lAJWGmo8PX7si88
 IDle+Gzgbo9nw4Mnw/g1cym/69lJFpO3dlPYcqkAnCdy/oLiI/uWeOT0tP4FQYucW8lP
 ZK8N9EG5t/WIUdpn2iFO6qUt1KbXWiV9M4n9mrckCUJfdtZkCY2jdM5bDCykX2tGtz1e
 2zp6mjZlq8R/lj9+n6jVlwH8yJ5mIZdpbBX86VREpR2lkjFtnS6bIsC9bDspeEDocKQw
 u8s5VQQkTmzQuqFRGTLvtJ4DEZkvrGZ/2ZZY9+NVVwBVQQhLRaMJ9zhU8hJegfHzovJb CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr62k1t4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 06:37:06 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A95SHbb013584;
        Wed, 9 Nov 2022 06:37:05 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr62k1t3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 06:37:05 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A96ZAqs002383;
        Wed, 9 Nov 2022 06:37:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kngqdd619-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 06:37:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A96bdAj51118414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 06:37:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506EB4C040;
        Wed,  9 Nov 2022 06:37:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 189474C059;
        Wed,  9 Nov 2022 06:37:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Nov 2022 06:37:01 +0000 (GMT)
Date:   Wed, 9 Nov 2022 07:36:59 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
Message-ID: <Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-1-torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108194139.57604-1-torvalds@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V-p-gepv-JjtVCpdUPM3yXLfoFt-c4gD
X-Proofpoint-GUID: rv-w7d64gYvLTMH2r6geoPP9I4zXBO2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_01,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=831 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 11:41:36AM -0800, Linus Torvalds wrote:

Hi Linus,

[...]

> +struct encoded_page;
> +#define ENCODE_PAGE_BITS 3ul
> +static inline struct encoded_page *encode_page(struct page *page, unsigned long flags)
> +{

Any reaction in case ((flags & ~ENCODE_PAGE_BITS) != 0)?

> +	return (struct encoded_page *)(flags | (unsigned long)page);
> +}

Thanks!
