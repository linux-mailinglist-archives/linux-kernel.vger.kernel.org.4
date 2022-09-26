Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7DB5E9E55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbiIZJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbiIZJur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:50:47 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E2356F3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:50:41 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220926095035epoutp024fd1da418fa6669a91fa3e7e9f4fc340~YYDM6e_UO0869808698epoutp02N
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:50:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220926095035epoutp024fd1da418fa6669a91fa3e7e9f4fc340~YYDM6e_UO0869808698epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1664185835;
        bh=/zr1yAK/VTTBVfo8kZ27scvqM4BRisVBYSwUlTHgzrE=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=F2aq/RgehZ1aFYLLpICKKv9Z3sOcxtz/gMeHlRaJhRgejbdu+b33Kb9xCOz2jBwzw
         aexTQG15nYigO5LwWy0UITBoAxFzbJkU6ANIzZ0gdtsMQBegjQSapRsKQjW/PaF+2P
         YSaj6yp4qxKd6LSN4Bx57Cua4LORXISTYpkEigDg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220926095035epcas1p4faacef45711294c23bbca978f7ae87b5~YYDMjXOe70141201412epcas1p4_;
        Mon, 26 Sep 2022 09:50:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.145]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MbdKk165cz4x9Q5; Mon, 26 Sep
        2022 09:50:34 +0000 (GMT)
X-AuditID: b6c32a38-31ffb70000021e0b-b0-633175eae032
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.9F.07691.AE571336; Mon, 26 Sep 2022 18:50:34 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [RESEND] devfreq: governor: Save void *data in the governor
 userspace
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Kant Fan <kant@allwinnertech.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allwinner-opensource-support@allwinnertech.com" 
        <allwinner-opensource-support@allwinnertech.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <ff876f76-85c8-15d6-4f55-831722608edd@allwinnertech.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220926095033epcms1p831e2cb7acfcdd9f9dc360deb6738b37c@epcms1p8>
Date:   Mon, 26 Sep 2022 18:50:33 +0900
X-CMS-MailID: 20220926095033epcms1p831e2cb7acfcdd9f9dc360deb6738b37c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmnu6rUsNkg5YrbBan/vYyWlz/8pzV
        4snGR8wWZ5vesFtc3jWHzeJz7xFGBzaPV23PmDz6tqxi9Pi8SS6AOSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLRArzgxt7g0L10vL7XEytDAwMgUqDAhO2PbtJ8sBculKpqOXmFs
        YNwq3MXIySEhYCJxunUKI4gtJLCDUWLtDLEuRg4OXgFBib87wEqEBSIkdn87yAZRoiTRcHMf
        M0RcX6LjwTawVjYBXYmtG+6ygNgiAhUSf+41s4LYzAIPGSWmLHSDWMUrMaP9KQuELS2xfflW
        sF5OAVeJBwvvs0LERSVurn7LDmO/PzafEcIWkWi9d5YZwhaUePBzNyPImSBzfl7R72LkAjIn
        M0qcPHGcEcKZwygxbcM7NogGfYkzc0+C2bwCvhLzzh0Gs1kEVCX2rFoLtcBF4su/R8wQR8tL
        bH87hxlkAbOApsT6XfoQYT6Jd197WGF+2THvCROErSZxaPcSqJtlJE5PXwh1p4fEhCcLWEHu
        ERL4ySSx4Pta1gmM8rMQwTsLybZZCNsWMDKvYhRLLSjOTU8tNiwwgUdocn7uJkZwstOy2ME4
        9+0HvUOMTByMhxglOJiVRHhTLuomC/GmJFZWpRblxxeV5qQWH2I0BfpzIrOUaHI+MN3mlcQb
        mlgamJgZGZtYGJoZKonzNszQShYSSE8sSc1OTS1ILYLpY+LglGpgiknKenvZdz3Pk30mCg8f
        ua1l3Hhk6jfljn1LEt/cdp9h+EtVLqJ097Nd05qnrteeq1J+KSui8lfwxxyRM/drpyafnrR4
        m/HJYxKzHUvf99y5VKE/g/fFxFq1hVOEduwK9l8puTXx0KrVkRwnF3nKCM9ffEZr0R+N9N0i
        8hPOSm2uZHdy3/asYa9QZeuv9AIeocaUH1Wm/BXqWTqPr3dO4HFR3dY1fR57zynti0/Yn6uz
        GE2bea7uQLCNYQbfiW182+6o7Hl/Z9acpTJm8UvdMqZ/cTizay73xc6GcP/5qaY7EvdEnXqZ
        FP0z5oTr73nxM28aZhpc/Tg9ddeLz0e5Pq6MmPhm5V/VB9O8V/deM72jxFKckWioxVxUnAgA
        x0bo4/8DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962
References: <ff876f76-85c8-15d6-4f55-831722608edd@allwinnertech.com>
        <a040e16c-e8e9-f550-7251-99ec1d18f508@allwinnertech.com>
        <20220329091449.105308-1-kant@allwinnertech.com>
        <20220914094355epcms1p8d6eeb0834e2d7c782d49558fac0ce6c4@epcms1p8>
        <8599d9df-3f56-1762-959d-01ee8c753a5b@allwinnertech.com>
        <CGME20220914091525epcas1p31c8a9b11ba7a36da4678e3254b0ea962@epcms1p8>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 9/15/2022 3:41 PM, Kant Fan wrote:
> > 
> > diff --git a/drivers/devfreq/governor_userspace.c 
> > b/drivers/devfreq/governor_userspace.c
> > index ab9db7a..d69672c 100644
> > --- a/drivers/devfreq/governor_userspace.c
> > +++ b/drivers/devfreq/governor_userspace.c
> > @@ -21,7 +21,7 @@
> > 
> >   static int devfreq_userspace_func(struct devfreq *df, unsigned long 
> > *freq)
> >   {
> > -    struct userspace_data *data = df->data;
> > +    struct userspace_data *data = df->governor_data;
> > 
> >       if (data->valid)
> >           *freq = data->user_frequency;
> > @@ -40,7 +40,7 @@
> >       int err = 0;
> > 
> >       mutex_lock(&devfreq->lock);
> > -    data = devfreq->data;
> > +    data = devfreq->governor_data;
> > 
> >       sscanf(buf, "%lu", &wanted);
> >       data->user_frequency = wanted;
> > @@ -60,7 +60,7 @@
> >       int err = 0;
> > 
> >       mutex_lock(&devfreq->lock);
> > -    data = devfreq->data;
> > +    data = devfreq->governor_data;
> > 
> >       if (data->valid)
> >           err = sprintf(buf, "%lu\n", data->user_frequency);
> > @@ -91,7 +91,7 @@
> >           goto out;
> >       }
> >       data->valid = false;
> > -    devfreq->data = data;
> > +    devfreq->governor_data = data;
> > 
> >       err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> >   out:
> > @@ -107,8 +107,8 @@
> >       if (devfreq->dev.kobj.sd)
> >           sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
> > 
> > -    kfree(devfreq->data);
> > -    devfreq->data = NULL;
> > +    kfree(devfreq->governor_data);
> > +    devfreq->governor_data = NULL;
> >   }
> > 
> >   static int devfreq_userspace_handler(struct devfreq *devfreq,
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index 34aab4d..d265af3 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -152,8 +152,8 @@
> >    * @max_state:        count of entry present in the frequency table.
> >    * @previous_freq:    previously configured frequency value.
> >    * @last_status:    devfreq user device info, performance statistics
> > - * @data:    Private data of the governor. The devfreq framework does not
> > - *        touch this.
> > + * @data:    devfreq core pass to governors, governor should not change 
> > it.
> > + * @governor_data:    private data for governors, devfreq core doesn't 
> > touch it.
> >    * @user_min_freq_req:    PM QoS minimum frequency request from user 
> > (via sysfs)
> >    * @user_max_freq_req:    PM QoS maximum frequency request from user 
> > (via sysfs)
> >    * @scaling_min_freq:    Limit minimum frequency requested by OPP 
> > interface
> > @@ -193,7 +193,8 @@
> >       unsigned long previous_freq;
> >       struct devfreq_dev_status last_status;
> > 
> > -    void *data; /* private data for governors */
> > +    void *data;
> > +    void *governor_data;
> > 
> >       struct dev_pm_qos_request user_min_freq_req;
> >       struct dev_pm_qos_request user_max_freq_req;
> > 
> 
> Hi MyungJoo,
> Sorry to disturb. Just want to say that I'm looking forward to your 
> advice on this patch. Thank you :>
> 

This new code looks good to me.
Anyway, Chanwoo, how do you think of this?


Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo.
