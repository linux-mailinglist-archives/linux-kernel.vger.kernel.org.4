Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30F85BC30F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiISGob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiISGo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:44:26 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B51C92F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:44:22 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220919064417epoutp02c8f71b8095449c3fb13a688f154fe664~WL-i09-qI0895008950epoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 06:44:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220919064417epoutp02c8f71b8095449c3fb13a688f154fe664~WL-i09-qI0895008950epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663569857;
        bh=FtAqeLE9eLSYZ70k5z3LQzvAizj5vQGBIwHoZe7dClI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gWVRqtQl8/w+8m4D4gZesjWaxaB10LgQFq0dJP0gBoVPPBNPKxK3njuB1wHJJETrh
         52QRvNPTJi+QanLrndthmdJl/mAr3Y2inxa61NLOr50CROLk9BAWzFrGq8krH7vtSI
         M6GLpG3T4qr3LIzykDNZtyQ8Mu1gHnA5Q7cWjbB8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220919064417epcas1p18ecb172d874ed47868bdfedf8d7c92f2~WL-iWJPkb1812318123epcas1p1p;
        Mon, 19 Sep 2022 06:44:17 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.132]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MWFX00yYgz4x9Q7; Mon, 19 Sep
        2022 06:44:16 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.4A.07691.FBF08236; Mon, 19 Sep 2022 15:44:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220919064415epcas1p2f9dc0241afb4b9d413bb2244d6608dce~WL-hH5CrD0346003460epcas1p2V;
        Mon, 19 Sep 2022 06:44:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220919064415epsmtrp2f8b8ef36f7d75e48e84cfc870d57e7bf~WL-hHBmo50522905229epsmtrp2F;
        Mon, 19 Sep 2022 06:44:15 +0000 (GMT)
X-AuditID: b6c32a38-8d6dba8000021e0b-4b-63280fbfe6b2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.6A.18644.FBF08236; Mon, 19 Sep 2022 15:44:15 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220919064415epsmtip13662b953a5833c00edddb3a6739ed64b~WL-g0yUSF2542525425epsmtip1O;
        Mon, 19 Sep 2022 06:44:15 +0000 (GMT)
Date:   Mon, 19 Sep 2022 15:44:15 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, ogabbay@kernel.org, krzysztof.kozlowski@linaro.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 07/13] trinity: Add sysfs module
Message-Id: <20220919154415.23457c66c2e2a76d02267af2@samsung.com>
In-Reply-To: <Yybz4j+Uz+aH7uT+@kroah.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmge4Bfo1kg/ddzBZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJC
        XmJuqq2Si0+ArltmDtBVSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc
        4tK8dL281BIrQwMDI1OgwoTsjFfTfrAWTBSqmPDmFnMDYz9fFyMnh4SAicTcpXMZuxi5OIQE
        djBKTG1eygLhfGKUWPttL5TzmVFi/5YrbDAt1+9uZ4VI7GKUeL/9CVRVB5PEjtW/mUGqWARU
        JQ60HmIFsdmA7Jkz1rCD2CICGhIvj94Ca2AWWM8oMblpD1hCWMBc4trZRWANvAKOEu8eNTCC
        2JwCmhKvjy1kglhtIXG3ZwVQDQdQjaDE3x3CIGFmAXmJ7W/nMIPMlBDo5ZA486iXFaLeRWLj
        sQ5GCFtY4tXxLewQtpTE53d7od7JlpjSsYgFwi6QOPd8KzPIfAkBY4mLK1JATGagE9bv0oeo
        UJTY+XsuI8RaPol3X3tYIap5JTrahCBKlCSW/DkMtUhCYuqMb1DHe0h0P94ODap7jBIt79aw
        TmBUmIXwzCwkz8xCWLyAkXkVo1hqQXFuemqxYYEJPIKT83M3MYITqZbFDsa5bz/oHWJk4mA8
        xCjBwawkwqvqqZIsxJuSWFmVWpQfX1Sak1p8iNEUGDUTmaVEk/OBqTyvJN7QxNLAxMzI2MTC
        0MxQSZxXT5sxWUggPbEkNTs1tSC1CKaPiYNTqoEpPFmsObOsTPXiK1WJRw6PDpe7qHP8eGGW
        zeq/+p977AnBQ/F/CyznKhvN39qwnHedySP9cnbl4m9/rDLvM5id+P610HayQ1Ojm+jeR0HX
        lzu0ffhu9jcl6PDWiU8NlbyXLEjx/eMxOVhOrSf6ttj2jJMXchtd08x4jxjNXfB+752ipY87
        5MOM53//tODBrgfdNwpzOdM/XLrrwcZ8pLDwxTM5g51rLc0ePzvrPmnOPJVLd+q/VyQvXvnq
        9YO1atcaZnLUaXmGShVeY7qpqrPMMYD5aF7sco/QVweKrFoUum72LOCawcMZxLzWelLJpraU
        L13rWA/5TIzas8763nrN0LYf/7mqvzXlL7/bqpOjxFKckWioxVxUnAgA6kMj8C0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSnO5+fo1kg++7VSz+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MV9N+sBZMFKqY8OYWcwNjP18XIyeH
        hICJxPW721m7GLk4hAR2MEqcPXiKGSIhIbHp3nIgmwPIFpY4fLgYoqaNSWLT1UdgNSwCqhIH
        Wg+xgthsQPbMGWvYQWwRAQ2Jl0dvsYDYzALrGSX2L1MHsYUFzCWunV0EVs8r4Cjx7lEDI4jN
        KaAp8frYQiaIBQ8YJX7d7meCOMJC4m7PClaQI3gFBCX+7hCGmKkl8fAXzHx5ie1v5zBPYBSc
        hVA1C0nVLCRVCxiZVzFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBEeIltYOxj2rPugd
        YmTiYDzEKMHBrCTCq+qpkizEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC
        1CKYLBMHp1QDU7BT7XrGliPhyxiSTp7Yas71mv+G6DzXvw9Uv+hvTO/bvmnGr/tzHT6J/JAV
        +9t6MGDh46pZH/+zSyScdZI4vWuDtktIxTpB1WkGu9UylvUJS7mI93P8vbNis2noySV+yZ/v
        mM5Y78h8fmb292DvawuWN/lOa3FbP3PZlvc2QRfyjMvV9j2SMGkqCMqwSLzAwWpvcXOdQN0D
        xraeBRPrJn5/4TZ/51WvS+8akzgTUhv1C73Tb3PdyjjrH7JadNummB8Sx1VulukIZ75zLpyf
        97wg9e7npaGmmqcaGLY1X5pQrWQr35D16AgH872sFVcUP59YYej4pDftTYr34Y5lGeG8dyeY
        PGGYWfm3/9unf0osxRmJhlrMRcWJAP19p9L/AgAA
X-CMS-MailID: 20220919064415epcas1p2f9dc0241afb4b9d413bb2244d6608dce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p485a1cdcb71cc01274db1c8d00aec197c@epcas1p4.samsung.com>
        <20220917072356.2255620-8-jiho.chu@samsung.com> <Yybz4j+Uz+aH7uT+@kroah.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sep 2022 12:33:06 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Sat, Sep 17, 2022 at 04:23:50PM +0900, Jiho Chu wrote:
> > This patch includes sysfs interfaces.
> > 
> > sysfs interface provides NPU's internal statistics, status and control
> > attribes.
> > 
> > The sysfs information provided by the Trinity are:
> > - IDU version
> > - profiling result
> > - allocated debugfs buffer
> > 
> > The control attributes are including:
> > - initialize profile operation
> > - NPU control (suspend/resume/stop)
> > 
> > Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> > Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
> > Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
> > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > ---
> >  .../ABI/testing/sysfs-driver-trinity          |  55 ++
> >  drivers/misc/trinity/Makefile                 |   1 +
> >  drivers/misc/trinity/trinity_sysfs.c          | 667 ++++++++++++++++++
> >  3 files changed, 723 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-trinity
> >  create mode 100644 drivers/misc/trinity/trinity_sysfs.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-trinity b/Documentation/ABI/testing/sysfs-driver-trinity
> > new file mode 100644
> > index 000000000000..754e6f36a1dc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-trinity
> > @@ -0,0 +1,55 @@
> > +What:           /sys/devices/platform/trinity/*.triv2/debug/debugfs_max
> > +Date:           July 2022
> > +KernelVersion:  5.19-rc8
> > +Contact:        Jiho Chu <jiho.chu@samsung.com>
> > +Description:    Shows current allocated debugfs entry size.
> > +                Note that, Writing max entry size allocates NPU's hardware
> > +                memory for debugfs entries.
> 
> Why are debugfs things being mentioned in sysfs entries?
> 
> That's not needed, nor is it allowed, sorry.
> 
> Please put all debugfs stuff in debugfs.
> 
> Also, sysfs is "one value per file", you violate that in lots of ways
> with this patch.  Please fix all of that, and use the sysfs_emit() calls
> instead of snprintf() for your sysfs show calls.
> 
> thanks,
> 
> greg k-h
> 

Thanks for checking.
I'll fix sysfs entries.

Best regards,
Jiho Chu

