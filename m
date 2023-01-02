Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57565AD74
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 07:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjABGbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 01:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjABGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 01:31:09 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D361CD1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 22:31:03 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230102063100epoutp029fa47a5ece5561022245dca279a048e6~2ai7J_6Et2652426524epoutp02G
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:31:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230102063100epoutp029fa47a5ece5561022245dca279a048e6~2ai7J_6Et2652426524epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672641060;
        bh=7tBwUf3Kq8nD/SIRcrI8SZniUmf4dKkROAwFjgpQz5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I/zRZb7yAYi237KtKyHu+SS6U33WfMoTSL4VzLOG1CaoazYv9wcqt6z1BqSN8tU5V
         8tRGsEQSSOS9ZT8Pxu1dBzUpokarreuj/AEwE8qjHl6wr4DQ+KQT6Q8GEatsVia4iy
         eK70AT4FYeJOST7jZ06XPJoAjabR7EjTMlv7AQ5g=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230102063100epcas2p39a2ec49e6a42b90112afc18707cbbd6a~2ai6o4n-n2056620566epcas2p39;
        Mon,  2 Jan 2023 06:31:00 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NlmGC5G4rz4x9Px; Mon,  2 Jan
        2023 06:30:59 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        20.18.03803.32A72B36; Mon,  2 Jan 2023 15:30:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230102063059epcas2p133914a8e92a801f6538c6e0c66a86ea0~2ai5f6fjo0942309423epcas2p1V;
        Mon,  2 Jan 2023 06:30:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230102063059epsmtrp26314cc103f1d301d78830e10301e6441~2ai5fDX9y0836308363epsmtrp2U;
        Mon,  2 Jan 2023 06:30:59 +0000 (GMT)
X-AuditID: b6c32a45-f47ff70000020edb-27-63b27a23f2ff
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.30.02211.22A72B36; Mon,  2 Jan 2023 15:30:58 +0900 (KST)
Received: from ubuntu (unknown [10.229.95.128]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230102063058epsmtip1ec0dfbd07b5ac7b086d5d6ea24bc971f~2ai5SPT021961819618epsmtip1U;
        Mon,  2 Jan 2023 06:30:58 +0000 (GMT)
Date:   Mon, 2 Jan 2023 15:24:48 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v2 1/3] usb: support Samsung Exynos xHCI Controller
Message-ID: <20230102062448.GC74470@ubuntu>
MIME-Version: 1.0
In-Reply-To: <bc531774-ed70-39b7-3534-5683dff20591@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmha5y1aZkg1edshbH2p6wW8w/co7V
        4tTyhUwWzYvXs1ncffiDxaLvxUNmi72vt7JbXN41h81i0bJWZovmTVNYLVr3HmG36Lp7g9Fi
        0kFRi1ULDrA78Hks3vOSyWPTqk42jzvX9rB57J+7ht2jb8sqRo8t+z8zenzeJBfAHpVtk5Ga
        mJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0spJCWWJOKVAo
        ILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pox/2M
        BZMkKyaeaWVtYJwp0sXIySEhYCKxcfIGli5GLg4hgR2MEr3PHrFCOJ8YJZa/OMoO4XxjlHjR
        eZ8JpmXJ90nMEIm9jBIn3m+CannCKPHmWhM7SBWLgIrEwy97wWw2AS2Jez9OMIPYIgIWEos3
        LARrYBZYxSKx/dVDFpCEsIC3xJyzPWA2r4C2RMv9OUwQtqDEyZlPwOKcAnYSXxp2AdkcHKJA
        C14drIe4aA+HxOF9ZRC2i8TEL1dYIWxhiVfHt7BD2FISn9/tZYOwsyWuf+tmgbArJFbshbGN
        JWY9a2cEsZkFMiT2LV/FBLJKQkBZ4sgtFogwn0TH4b/sEGFeiY42IYhOZYnplydAbZWUOPj6
        HDOE7SGx/dgnaPB2Mkl8mdzMPoFRfhaSx2Yh2QZh60gs2P2JbRbQCmYBaYnl/zggTE2J9bv0
        FzCyrmIUSy0ozk1PLTYqMIRHdnJ+7iZGcGrWct3BOPntB71DjEwcjIcYJTiYlUR4L39elyzE
        m5JYWZValB9fVJqTWnyI0RQYTROZpUST84HZIa8k3tDE0sDEzMzQ3MjUwFxJnDdo6/xkIYH0
        xJLU7NTUgtQimD4mDk6pBibDaY+a93S3tbrnq1w4/uLp2fTV6Ue22WxuvMsdnbdQb06oj9fr
        qyceT1zOtPdQ9za1uV8yH3gcYbqzNI053K789LPinf9zXZsY1zVyFthrJxXIPpTvqk8L89/6
        ojOM7Xnd0ldqJ66E/+1zt9p3kFfF9GNlDOObnGmK9efk1/+Nr+5WPiZ1rrrXdoOGugULr+HL
        L0VlB73vXmC9139i2dGJgXoaKbvN3yZr+53efX56/MoLR44fmvmy7Ydqf2FQwMl7bzz1pZ2W
        W36/1v575fOguvq6klN/3tb0eCuurN/caCDPXaTnm2OWuGI7T2mAdXJI6O8XHqbz3ilNq+CK
        87OYOvFItl9oqWxi88mCf0osxRmJhlrMRcWJABANY39WBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTlepalOywZFmC4tjbU/YLeYfOcdq
        cWr5QiaL5sXr2SzuPvzBYtH34iGzxd7XW9ktLu+aw2axaFkrs0XzpimsFq17j7BbdN29wWgx
        6aCoxaoFB9gd+DwW73nJ5LFpVSebx51re9g89s9dw+7Rt2UVo8eW/Z8ZPT5vkgtgj+KySUnN
        ySxLLdK3S+DKOPRhH3PBJbGKXw1NjA2MnwS7GDk5JARMJJZ8n8QMYgsJ7GaUeDjLCiIuKbF0
        7g12CFtY4n7LEdYuRi6gmkeMEk8uzWIDSbAIqEg8/LIXrIhNQEvi3o8TYINEBCwkFm9YyApi
        MwusY5HYOjkexBYW8JaYc7aHBcTmFdCWaLk/hwliaCeTxJw7q5ghEoISJ2c+YYFo1pK48e8l
        UBEHkC0tsfwfB0iYU8BO4kvDLhaQsCjQDa8O1k9gFJyFpHkWkuZZCM0LGJlXMUqmFhTnpucW
        GxYY5qWW6xUn5haX5qXrJefnbmIER5aW5g7G7as+6B1iZOJgPMQowcGsJMJ7+fO6ZCHelMTK
        qtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYChUdXRsV+RUeH123
        +9mDS8Yn4gRn5csLfjH4U1z6im3R5cVR5avchb35Yg3yLvcHGNfJrjSZYKvSaCfFEOn3KnRr
        eYLzc0uBmx9NJO02zIsNWXb+Yk3cs5ctU/dwxwTw7mfee5NLt97WwbnlN//Uf21+18yllWpT
        bxQeTuAU91mzWrD9/u69Oa3vfPQseNSSp+7/t/jn6RNuR3bI8ObMDZC4n1oQzHvifJdLtOLf
        2MTn37l/HVAoWdnEe/R1Wciqlc17lx/y3vInI0DjzhIZ19jL21mYN/xnT+Ew3upSd+fdc6+r
        sv7tiRmvjh9Xirg38YHplVXJcgZC9y+8iHnJt1b3RCN7u1PzjsYrtxWVWIozEg21mIuKEwHo
        kiLpGwMAAA==
X-CMS-MailID: 20230102063059epcas2p133914a8e92a801f6538c6e0c66a86ea0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_e4814_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
        <CGME20221229100413epcas2p34c702faf8c96d207cf1659b1173f8858@epcas2p3.samsung.com>
        <1672307866-25839-2-git-send-email-dh10.jung@samsung.com>
        <bc531774-ed70-39b7-3534-5683dff20591@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_e4814_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Dec 29, 2022 at 11:25:58AM +0100, Krzysztof Kozlowski wrote:
> On 29/12/2022 10:57, Daehwan Jung wrote:
> > Currently, dwc3 invokes just xhci platform driver without any data.
> > We add xhci node as child of dwc3 node in order to get data from
> > device tree. It populates "xhci" child by name during initialization
> > of host. This patch only effects if dwc3 node has a child named "xhci"
> > not to disturb original path.
> > 
> > We add "samsung,exynos-xhci" compatible in xhci platform driver
> 
> Where? It is not documented.

I submitted the patch of dt bindings on same patchset.
Is there any missing documentation?

> 
> > to support Exynos SOCs. 
> 
> That's so not true. You do nothing to support Exynos SoC here. Please
> stop pasting incorrect and misleading commit msgs.

I agree misleading commit msgs. I will modify it.

> 
> > We introduce roothub wakeup, which uses roothub
> > as system wakeup source. It needs xhci platform driver to override
> > roothub ops.
> 
> You did not explain why you introduced wakelocks...
> 

I'm sorry I didn't write description enough.
I add it below.

> 
> (...)
> 
> >  	if (shared_hcd) {
> >  		usb_remove_hcd(shared_hcd);
> >  		xhci->shared_hcd = NULL;
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index 79d7931c048a..693495054001 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> > @@ -5502,6 +5502,10 @@ void xhci_init_driver(struct hc_driver *drv,
> >  			drv->check_bandwidth = over->check_bandwidth;
> >  		if (over->reset_bandwidth)
> >  			drv->reset_bandwidth = over->reset_bandwidth;
> > +		if (over->bus_suspend)
> > +			drv->bus_suspend = over->bus_suspend;
> > +		if (over->bus_resume)
> > +			drv->bus_resume = over->bus_resume;
> >  	}
> >  }
> >  EXPORT_SYMBOL_GPL(xhci_init_driver);
> > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > index c9f06c5e4e9d..cb9c54a6a22c 100644
> > --- a/drivers/usb/host/xhci.h
> > +++ b/drivers/usb/host/xhci.h
> > @@ -1752,6 +1752,8 @@ struct xhci_hub {
> >  struct xhci_hcd {
> >  	struct usb_hcd *main_hcd;
> >  	struct usb_hcd *shared_hcd;
> > +	struct wakeup_source *main_wakelock;
> > +	struct wakeup_source *shared_wakelock;
> 
> Drop wakelocks. This is not related to USB and not needed here. Do you
> see anywhere else in core kernel code usage of the wakelocks?
> 
> You got this comment already, didn't you? So why you do not address it?
> 

I want to add a new feature in xhci platform driver. I want to make it
possible to enter system sleep while usb host connected like USB Mouse.
It gets system enter sleep only if there's no usb transaction at all.
Deciding if there's tranaction or not is in root hub because it's parent
of all child usb devices.

Best Regards,
Jung Daehwan

> Best regards,
> Krzysztof
> 
> 

------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_e4814_
Content-Type: text/plain; charset="utf-8"


------q0R.rfVsiCQSGj.gN--CgCxe04.wFXW5ZK4nZZPhzE8cX7uJ=_e4814_--
