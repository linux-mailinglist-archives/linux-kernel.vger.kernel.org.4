Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4C6E061F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDMEtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDMEts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:49:48 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7484EFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:49:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517c0b93cedso732706a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1681361387; x=1683953387;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGyiOScylqXAdZpSr8RgAbr7p829gfYVCOhKVD812r4=;
        b=sPkX6Ou6OJI2CBFPo9AWJLlkPzrm+7ioKjVMZ+4ui3MBsAkNyvHMEzzLQTiXGDp4WW
         yql3CbfDWYtvYIGYe3kB9hR+SmY9cEXKJP0xZfA3wvvjE0Pvf9ITg0SKSxq9Xfg5yTGe
         9SQxe6zVbULOQGxq+3dZsnqqotEt6L0cNT8KsWHkcMk7rvmn1gu7eCQDNW8jbiM9w/0G
         FOoqIEe5lZlaS98umeqOlkdzeId9pjz3LaH5/VDtPM9EVZwdj7I7L9YToWp0v2cNfweV
         xC0i6E8XgK/WRiEtuuppdCB+b/3Z0mnl+WItMqnu5VBHrvoM9JPrB5K8B/lxVFLZsalR
         NgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681361387; x=1683953387;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGyiOScylqXAdZpSr8RgAbr7p829gfYVCOhKVD812r4=;
        b=I7N5kIr4I8PEQ+ch8YGk8z7IWEJWiOjWH8ZrvrzKubTWL1Z4La7/Tic/eHArKlxToe
         ArKSqdcnDlAm4DWHAQKe5Hkwdco84zZ0zpm6yNxi51WDiaYV9FFJD55OTahSCF1EPvPF
         u7WVs/yxidEdCZyOwAN5qxrd0A6jb7+jwHC02YmNsEBDeD+6Arv+bxvTgeE2DQPT3Dkq
         00ysLncW5q0CCjBwRQQ54aD3B7sUOXvAFhUUILstanI8cFavOZCVaIN7U3/QXZx0tgkr
         4lKCnqQXCJeWC+foQn1uhCPMDfHUxYfnWNi290HuzKGb/vUgaYEMQ3EgPvb55GrfEFb+
         7i2w==
X-Gm-Message-State: AAQBX9ft1AgW0dYp5UHiHuRxMjD4wxsEhGmglk2hjx4mJWOdAn8HV4/N
        lriAmf4pjtrxhpqjAwOEtyz+jg==
X-Google-Smtp-Source: AKy350bhe7B+4dvtK2pD4mPR5OiusqFeoFo+uINW+/npzRsV+nnljFUiGebPyjpV5+e1C81/HztRBA==
X-Received: by 2002:a05:6a00:248d:b0:63b:165c:fb6b with SMTP id c13-20020a056a00248d00b0063b165cfb6bmr1743546pfv.18.1681361386685;
        Wed, 12 Apr 2023 21:49:46 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78d90000000b005ae02dc5b94sm297857pfr.219.2023.04.12.21.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 21:49:46 -0700 (PDT)
Message-ID: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
Date:   Thu, 13 Apr 2023 13:49:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: virtio-iommu hotplug issue
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Recently I encountered a problem with the combination of Linux's 
virtio-iommu driver and QEMU when a SR-IOV virtual function gets 
disabled. I'd like to ask you what kind of solution is appropriate here 
and implement the solution if possible.

A PCIe device implementing the SR-IOV specification exports a virtual 
function, and the guest can enable or disable it at runtime by writing 
to a configuration register. This effectively looks like a PCI device is 
hotplugged for the guest. In such a case, the kernel assumes the 
endpoint is detached from the virtio-iommu domain, but QEMU actually 
does not detach it.

This inconsistent view of the removed device sometimes prevents the VM 
from correctly performing the following procedure, for example:
1. Enable a VF.
2. Disable the VF.
3. Open a vfio container.
4. Open the group which the PF belongs to.
5. Add the group to the vfio container.
6. Map some memory region.
7. Close the group.
8. Close the vfio container.
9. Repeat 3-8

When the VF gets disabled, the kernel assumes the endpoint is detached 
from the IOMMU domain, but QEMU actually doesn't detach it. Later, the 
domain will be reused in step 3-8.

In step 7, the PF will be detached, and the kernel thinks there is no 
endpoint attached and the mapping the domain holds is cleared, but the 
VF endpoint is still attached and the mapping is kept intact.

In step 9, the same domain will be reused again, and the kernel requests 
to create a new mapping, but it will conflict with the existing mapping 
and result in -EINVAL.

This problem can be fixed by either of:
- requesting the detachment of the endpoint from the guest when the PCI 
device is unplugged (the VF is disabled)
- detecting that the PCI device is gone and automatically detach it on 
QEMU-side.

It is not completely clear for me which solution is more appropriate as 
the virtio-iommu specification is written in a way independent of the 
endpoint mechanism and does not say what should be done when a PCI 
device is unplugged.

Regards,
Akihiko Odaki
