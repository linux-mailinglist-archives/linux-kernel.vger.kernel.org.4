Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2645E69B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIVRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiIVRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:37:01 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A1EE8D9E;
        Thu, 22 Sep 2022 10:36:59 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MGaMXu026300;
        Thu, 22 Sep 2022 17:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : content-type : in-reply-to
 : mime-version; s=pps0720;
 bh=E9lc6cW2y39I1SUIBZrNbhAdKSaA4WDnEKCo98UTRNA=;
 b=BL8AIgjsQaJ6iFhMLsEoeXYys9SKHwAf4dSzS3akbiN3XaP+WBnAM+XSl8sLCcgPaBj8
 3MkyRsMcqaEtITeFoS1NeIa+uoN3h0bsSpnEibFfKUxQVTkbfLTfzzyhGBhq/dL0dFez
 MyG8lHXrzi1RCWZsvdllU4cISSvgAAr9RXS9eCzsOz0D4bFbaQNwdwLxLX416i0MpuHW
 NT3LtO8e9+e/nUVBOjRLyoQceFhv3AdiHjR+eRadeuZkY7H4AGjH82LuB8f48ObVRzCB
 u03al+tTIXGpxWF3hTalo/7dGRthoHzq3HtTtCQ5LVxcljrhBsJMhQLS0a+tiPvW8cpo SA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jru2m0nnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Sep 2022 17:36:40 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DDE73802097;
        Thu, 22 Sep 2022 17:36:38 +0000 (UTC)
Received: from rfwz62 (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id EAA4680764C;
        Thu, 22 Sep 2022 17:36:37 +0000 (UTC)
Date:   Thu, 22 Sep 2022 11:36:35 -0600
From:   rwright@hpe.com
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sp5100_tco: Add "action" module parameter
Message-ID: <20220922173635.GJ18783@rfwz62>
Reply-To: rwright@hpe.com
References: <20220920092721.7686-1-git@vladimir.panteleev.md>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920092721.7686-1-git@vladimir.panteleev.md>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: F9eC5488Np6eNV2FsM_-fW94Ne62opkY
X-Proofpoint-ORIG-GUID: F9eC5488Np6eNV2FsM_-fW94Ne62opkY
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_12,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209220116
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:27:21AM +0000, Vladimir Panteleev wrote:
> Allow configuring the "action" bit, as documented in [1].
> 
> Previously, the only action supported by this module was to reset the
> system (0).  It can now be configured to power off (1) instead.
> 
> [1]: https://www.amd.com/system/files/TechDocs/44413.pdf

The referenced AMD document 44413 is over 10 years old, and I'm
concerned when I try to line that document up against the newer versions
that are implemented in AMD's EPYC processors, that the bit being
manipulated as SP5100_WDT_ACTION_RESET is effectively reserved in the
newer references, for example:

   https://www.amd.com/system/files/TechDocs/55772-A1-PUB.zip

Is Core::X86::Msr::CpuWdtCfg in the newer document is the same as
WatchDogControl in the cited 44413.pdf? If so, then I would point out
that bit 2 is now included in what is called, CpuWdtTimeBase where
values 2-3H are reserved,  meaning bit 2 effectively must be zero.

-- 
Randy Wright            Hewlett Packard Enterprise
Phone: (970) 898-0998   Mail: rwright@hpe.com
