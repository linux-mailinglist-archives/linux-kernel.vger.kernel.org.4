Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C67A6DDF05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjDKPJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjDKPJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:09:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB80527A;
        Tue, 11 Apr 2023 08:09:04 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BE2BKY013011;
        Tue, 11 Apr 2023 15:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GlKyS851mvhNRkygM2H2YDVF7owvw/buclM8jjXT8ls=;
 b=pgeelPmp2VHNYlzLOzIgw6U6/3r+9IUoFrjNRNnTWUCBo5RPhhOYkEuvIHNaJ0QCEQKl
 I73tmLg49ChySqH1EnKpwqr7Z2li31eFkUiT5wwdmcM/Rdzli3iy4qtM0XWW8/ftPClB
 l6QyTjxr8Gos3KolTSDwax3RwMtX84hw0uxGQ6UYbNZp8UkPiMuNEQlMMGprAG/k+dDl
 YQOW+/NDPAb6KRQPrlpknJkbZ3aA1vLxnzjFeiNeQKj4/sElCK+T/rDXyqBA+lkLRWuo
 WvwjBNZNfTnqt9p+GqPh3R58immzXE+NcMzjBfXzIVEp5UagDypgNCl3WbqdO9GgHh4n eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvq4djaqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 15:08:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33BF8fQ8006048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 15:08:41 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 11 Apr
 2023 08:08:40 -0700
Message-ID: <1094266f-d845-9fa4-9f44-85de8352c04f@quicinc.com>
Date:   Tue, 11 Apr 2023 09:08:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: linux-next: build failure after merge of the driver-core tree
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Oded Gabbay <ogabbay@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
References: <20230411143812.11a4b00d@canb.auug.org.au>
 <ZDUuiB+E1tIJ95LY@phenom.ffwll.local> <2023041123-tractor-quake-c44d@gregkh>
 <ZDV2Nvs57Orx47tj@phenom.ffwll.local>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <ZDV2Nvs57Orx47tj@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wZhqxzZyL9cRef5WOovGBZ8cAVfjYBnt
X-Proofpoint-GUID: wZhqxzZyL9cRef5WOovGBZ8cAVfjYBnt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_10,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110136
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2023 9:01 AM, Daniel Vetter wrote:
> On Tue, Apr 11, 2023 at 12:40:28PM +0200, Greg KH wrote:
>> On Tue, Apr 11, 2023 at 11:55:20AM +0200, Daniel Vetter wrote:
>>> On Tue, Apr 11, 2023 at 02:38:12PM +1000, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> After merging the driver-core tree, today's linux-next build (x86_64
>>>> allmodconfig) failed like this:
>>>>
>>>> In file included from include/linux/linkage.h:7,
>>>>                   from include/linux/kernel.h:17,
>>>>                   from drivers/accel/qaic/mhi_qaic_ctrl.c:4:
>>>> drivers/accel/qaic/mhi_qaic_ctrl.c: In function 'mhi_qaic_ctrl_init':
>>>> include/linux/export.h:27:22: error: passing argument 1 of 'class_create' from incompatible pointer type [-Werror=incompatible-pointer-types]
>>>>     27 | #define THIS_MODULE (&__this_module)
>>>>        |                     ~^~~~~~~~~~~~~~~
>>>>        |                      |
>>>>        |                      struct module *
>>>> drivers/accel/qaic/mhi_qaic_ctrl.c:544:38: note: in expansion of macro 'THIS_MODULE'
>>>>    544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
>>>>        |                                      ^~~~~~~~~~~
>>>> In file included from include/linux/device.h:31,
>>>>                   from include/linux/mhi.h:9,
>>>>                   from drivers/accel/qaic/mhi_qaic_ctrl.c:5:
>>>> include/linux/device/class.h:229:54: note: expected 'const char *' but argument is of type 'struct module *'
>>>>    229 | struct class * __must_check class_create(const char *name);
>>>>        |                                          ~~~~~~~~~~~~^~~~
>>>> drivers/accel/qaic/mhi_qaic_ctrl.c:544:25: error: too many arguments to function 'class_create'
>>>>    544 |         mqc_dev_class = class_create(THIS_MODULE, MHI_QAIC_CTRL_DRIVER_NAME);
>>>>        |                         ^~~~~~~~~~~~
>>>> include/linux/device/class.h:229:29: note: declared here
>>>>    229 | struct class * __must_check class_create(const char *name);
>>>>        |                             ^~~~~~~~~~~~
>>>>
>>>> Caused by commit
>>>>
>>>>    1aaba11da9aa ("driver core: class: remove module * from class_create()")
>>>>
>>>> interacting with commit
>>>>
>>>>    566fc96198b4 ("accel/qaic: Add mhi_qaic_cntl")
>>>>
>>>> from the drm tree.
>>>>
>>>> I have applied the following merge fix patch for today.
>>>>
>>>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>>>> Date: Tue, 11 Apr 2023 14:16:57 +1000
>>>> Subject: [PATCH] fixup for "driver core: class: remove module * from class_create()"
>>>>
>>>> interacting with "accel/qaic: Add mhi_qaic_cntl"
>>>>
>>>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>>>
>>> Thanks for the fixup. Since Dave is out I've made a note about this in my
>>> handover mail so it won't get lost in the drm-next merge window pull. I
>>> don't think we need any other coordination than mention it in each pull to
>>> Linus, topic tree seems overkill for this. Plus there's no way I can
>>> untangle the drm tree anyway :-).
>>
>> Want me to submit a patch for the drm tree that moves this to use
>> class_register() instead, which will make the merge/build issue go away
>> for you?  That's my long-term goal here anyway, so converting this new
>> code to this api today would be something I have to do eventually :)
> 
> We kinda closed drm-next for feature work mostly already (just pulling
> stuff in from subtrees), so won't really help for this merge window.
> 
> For everything else I think this is up to Oded, I had no idea qaic needed
> it's entire own dev class and I don't want to dig into this for the risk I
> might freak out :-)
> 
> Adding Oded.
> 
> Cheers, Daniel

Sorry for the mess.

I made a note to update to class_register() once my drm-misc access is 
sorted out.  Looks like we'll address the conflict in the merge window, 
and catch the update to the new API in the following release.

-Jeff
