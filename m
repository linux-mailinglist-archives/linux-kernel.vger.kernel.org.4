Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9116E0BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjDMLCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjDMLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:01:59 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F35186
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:01:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i8so5577475plt.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 04:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681383718; x=1683975718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=or7wHY2yF8FKhqgQ0JlTfQUwpZSpEvdswbCSilx9uV8=;
        b=CnLf5BqmAtqo98jQhVbLGZlL5XPVQv0kIbAAOc6+u9Hwsyu64xxcavjq850WQ0EDDm
         5XJbuzZPy2LfzGo6gNmCAP0NqIyXHJh/1vfDxdD7LBau+SWtewx+3VSTcBmMcz4O15Qx
         AhUGgerwPQjcufCCH39GF6N3yUwZsUEfr+Lra22IsDww+M29Wt5ZtpYR0LyNkJEIv00U
         JzAzyQQSLcvlrMFRzrRMyFhUtpsIMsTek/JXLAOqFnOavXTIGLPq7TL5X0UbjOSPfSDz
         c8lb+ePOB9Ncq8Qyx13z4T6xFXCVA1jpoSALxINEP8xlFsCqQ8Ai5YQ8PrrU91hOILR+
         rwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681383718; x=1683975718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or7wHY2yF8FKhqgQ0JlTfQUwpZSpEvdswbCSilx9uV8=;
        b=iKLW7RyWUo4L7Fv89AwEJgfoXZaDxlWmOsPd4B5iRopj2u/DC0lHPQxPZ0JEYrcjaw
         IAn6DR8KC/6ZIFcx2dkJ3rHntmTzIh71fZ/CKomTX07ECGGQo/PC5aO5oGsxjZ4AAMT8
         oWWqDEqfuAc7EVAavsXdAN9GhlBDmTeHzxsnwxutc6FUIZsHqUvCOIiV9eEppQ807hf5
         B/9sls5gCKawQrh07v/hXLL8IFRafVwgTEHc/MKWCTi9eCJlrC/gnPLOyKLeNIWYMh2O
         ue1yvzo7/RibxzIug/RrhzEq8y57EfDyGITuwYkte40lXRNnwunC3yxNQ7khl9NM+23U
         iM5A==
X-Gm-Message-State: AAQBX9dk0EXBsNN5MdlSp2P/lOo0/66iHTDhD5hZmMq+dlf/2PXqorAF
        D2vhecl7ayRghNuV1ZdetV9/C9LA0AOlW8jI4PY=
X-Google-Smtp-Source: AKy350bETWVt0Dg1mDlAGsdQqS/IKqY3EbnbZLkprpNyZAo1j/klHs8mBY+NPYETOP+ZrGUteY/wKA==
X-Received: by 2002:a05:6a20:e20:b0:db:f682:65ed with SMTP id ej32-20020a056a200e2000b000dbf68265edmr1745809pzb.61.1681383717723;
        Thu, 13 Apr 2023 04:01:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id n9-20020a62e509000000b0063b5defe7ebsm12882pff.209.2023.04.13.04.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:01:57 -0700 (PDT)
Message-ID: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
Date:   Thu, 13 Apr 2023 20:01:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: virtio-iommu hotplug issue
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Eric Auger <eric.auger@redhat.com>,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230413104041.GA3295191@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/04/13 19:40, Jean-Philippe Brucker wrote:
> Hello,
> 
> On Thu, Apr 13, 2023 at 01:49:43PM +0900, Akihiko Odaki wrote:
>> Hi,
>>
>> Recently I encountered a problem with the combination of Linux's
>> virtio-iommu driver and QEMU when a SR-IOV virtual function gets disabled.
>> I'd like to ask you what kind of solution is appropriate here and implement
>> the solution if possible.
>>
>> A PCIe device implementing the SR-IOV specification exports a virtual
>> function, and the guest can enable or disable it at runtime by writing to a
>> configuration register. This effectively looks like a PCI device is
>> hotplugged for the guest.
> 
> Just so I understand this better: the guest gets a whole PCIe device PF
> that implements SR-IOV, and so the guest can dynamically create VFs?  Out
> of curiosity, is that a hardware device assigned to the guest with VFIO,
> or a device emulated by QEMU?

Yes, that's right. The guest can dynamically create and delete VFs. The 
device is emulated by QEMU: igb, an Intel NIC recently added to QEMU and 
projected to be released as part of QEMU 8.0.

> 
>> In such a case, the kernel assumes the endpoint is
>> detached from the virtio-iommu domain, but QEMU actually does not detach it.
>>
>> This inconsistent view of the removed device sometimes prevents the VM from
>> correctly performing the following procedure, for example:
>> 1. Enable a VF.
>> 2. Disable the VF.
>> 3. Open a vfio container.
>> 4. Open the group which the PF belongs to.
>> 5. Add the group to the vfio container.
>> 6. Map some memory region.
>> 7. Close the group.
>> 8. Close the vfio container.
>> 9. Repeat 3-8
>>
>> When the VF gets disabled, the kernel assumes the endpoint is detached from
>> the IOMMU domain, but QEMU actually doesn't detach it. Later, the domain
>> will be reused in step 3-8.
>>
>> In step 7, the PF will be detached, and the kernel thinks there is no
>> endpoint attached and the mapping the domain holds is cleared, but the VF
>> endpoint is still attached and the mapping is kept intact.
>>
>> In step 9, the same domain will be reused again, and the kernel requests to
>> create a new mapping, but it will conflict with the existing mapping and
>> result in -EINVAL.
>>
>> This problem can be fixed by either of:
>> - requesting the detachment of the endpoint from the guest when the PCI
>> device is unplugged (the VF is disabled)
> 
> Yes, I think this is an issue in the virtio-iommu driver, which should be
> sending a DETACH request when the VF is disabled, likely from
> viommu_release_device(). I'll work on a fix unless you would like to do it

It will be nice if you prepare a fix. I will test your patch with my 
workload if you share it with me.

Regards,
Akihiko Odaki

> 
>> - detecting that the PCI device is gone and automatically detach it on
>> QEMU-side.
>>
>> It is not completely clear for me which solution is more appropriate as the
>> virtio-iommu specification is written in a way independent of the endpoint
>> mechanism and does not say what should be done when a PCI device is
>> unplugged.
> 
> Yes, I'm not sure it's in scope for the specification, it's more about
> software guidance
> 
> Thanks,
> Jean
