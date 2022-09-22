Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F875E5883
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIVCVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVCVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:21:07 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E970E5B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:21:05 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220922022100epoutp03ef5a0a20c8fe7fc4af60824beb5241d0~XDVhk5Uwc2894428944epoutp034
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:21:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220922022100epoutp03ef5a0a20c8fe7fc4af60824beb5241d0~XDVhk5Uwc2894428944epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663813260;
        bh=IzYKUMJMz1SOuLrQwo03HvM/j9w6HxFH2Gbg2lnVnmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nmGVEt/p1jY8ziJOfWfIs5SVNZIRtHRXtMVxfMato/75GebwsFGDMw1t9NFlCzO5Y
         0+B5d6JrIBn3x1poITZgnQXfRAOrwWZ4GmnzoU/S6nAc1gND+GpuqSeST/731kdzNu
         s3sL+VZ4KUpEEqvWkwedKKuoNYE9kmIPTHTlTw70=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220922022100epcas1p4455e5c35a91d32b703f71552eb083e8f~XDVhIaC4k0554705547epcas1p4D;
        Thu, 22 Sep 2022 02:21:00 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.232]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4MXzXp4pdCz4x9Q3; Thu, 22 Sep
        2022 02:20:58 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.5A.51827.886CB236; Thu, 22 Sep 2022 11:20:56 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220922022056epcas1p1c95a2fbb5bd55e254387c2c457732b13~XDVdlG5z70207302073epcas1p1d;
        Thu, 22 Sep 2022 02:20:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220922022056epsmtrp185b0b87135b10315d964d258804e9509~XDVdj9eUY2543925439epsmtrp1G;
        Thu, 22 Sep 2022 02:20:56 +0000 (GMT)
X-AuditID: b6c32a36-72a32a800000ca73-30-632bc6889860
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C2.68.18644.886CB236; Thu, 22 Sep 2022 11:20:56 +0900 (KST)
Received: from jiho-chu04.tn.corp.samsungelectronics.net (unknown
        [10.113.112.236]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220922022056epsmtip274389d8678a4e23ae4addce2032c92cf~XDVdWHAWw3124431244epsmtip2u;
        Thu, 22 Sep 2022 02:20:56 +0000 (GMT)
Date:   Thu, 22 Sep 2022 11:20:55 +0900
From:   Jiho Chu <jiho.chu@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH v2 13/13] dt-bindings: arm: Add Samsung Trinity bindings
Message-Id: <20220922112055.46c1e55453d16383666ebe27@samsung.com>
In-Reply-To: <68a87470-2946-cdd0-f1a4-0c0bac906e8c@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOJsWRmVeSWpSXmKPExsWy7bCmvm7HMe1kgw3NahZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJC
        XmJuqq2Si0+ArltmDtBVSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc
        4tK8dL281BIrQwMDI1OgwoTsjCf/rrMU3DCo2HC+vIFxhUoXIyeHhICJxJ1l05m7GLk4hAR2
        MEoc+XmOCcL5xChxqGMRVOYzo8ScQ/9ZYVoaV2xhh0jsYpRo2LSAFcLpYJI4eXgzM0gVi4Cq
        RMPhdywgNhuQPXPGGnYQW0TAQmLxhoVgDcwCqxkl9k5dBDZWWMBH4uO552DNvAKOEs93fGMC
        sTkF7CT+XX3ACLHaQuJuzwqgeg6gGkGJvzuEQcLMAvIS29/OATtVQmAih0TLludsIDUSAi4S
        vU8TIVqFJV4d38IOYUtJvOxvg7KzJaZ0LGKBsAskzj3fygzRaixxcUUKiMksoCmxfpc+RIWi
        xM7fcxkhtvJJvPvawwpRzSvR0SYEUaIkseTPYajhEhJTZ0D8ISHgIfGg+z2YLSTwjVFi5zum
        CYwKsxBemYXklVkIexcwMq9iFEstKM5NTy02LDCCx25yfu4mRnAK1TLbwTjp7Qe9Q4xMHIyH
        GCU4mJVEeGff0UwW4k1JrKxKLcqPLyrNSS0+xGgKjJiJzFKiyfnAJJ5XEm9oYmlgYmZkbGJh
        aGaoJM7bMEMrWUggPbEkNTs1tSC1CKaPiYNTqoFpSXhrW9138UK9Z1G7q/41chacnLnwlZZY
        6K7jwXvrZGNblpz86sSiyea+yteLrTDR6G6faHhQ+rIVa0+cW7rSZ2MYd276DMG7V5dp7X/n
        yZagnri19dCDPv6bzyxPtjArx0Z8lueaIeHrcejZ8q0vcrdFPHP7vZehwcHcV+5jSvDCU7nr
        z7Euyg1+nr9USXVK5Wb9FxUXl2SbqovpvFLZvmjb7NOf5XYUqnbZsRl7vUlKijl+VDzo6eIL
        DbcEmP1/u35g5DrG9rG55HdN7cnKWYLPJ0qsv+0z+0hNCNOXTds3uMkFXHnQHXExf+XqA9Xn
        ZMOzjjxklWNNbwpZt8b2+6eJzaqJeQaZ/aru+cuUWIozEg21mIuKEwHR8Wx7KgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvG7HMe1kg9UH+Cz+TjrGbjH14RM2
        i+bF69ks3nfvZrbY+3oru8XlXXPYLG43rmCz2NfzkdHi+bTrLA6cHr9/TWL02LSqk83jzrU9
        bB77565h9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6MJ/+usxTcMKjYcL68gXGFShcjJ4eE
        gIlE44ot7F2MXBxCAjsYJfY/amCGSEhIbLq3HMjmALKFJQ4fLgYJCwm0MUl8eswDYrMIqEo0
        HH7HAmKzAdkzZ6xhB7FFBCwkFm9YyAoyk1lgNaPExLbJTCAJYQEfiY/nnoPN5xVwlHi+4xtY
        nFPATuLf1QeMEAu+MUrsfMcEcYOFxN2eFawgN/AKCEr83SEMEmYW0JJ4+OsWC4QtL7H97Rzm
        CYyCsxCqZiGpmoWkagEj8ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjODo0NLawbhn
        1Qe9Q4xMHIyHGCU4mJVEeGff0UwW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6Yklq
        dmpqQWoRTJaJg1OqgUl+/WbZs+H2DdIr7jSEPqoxnP/6tZJn14lYX+bYi2erb/cf+vJAskqQ
        xa315WVlZXPxtE9Wmqo7PC8f9Wg/NmUbb0y+/ordtn9sv/l/auM2Ohvkynv26e8by+dkb+ue
        vPzf40Wr/4uvVDdmeFEg28q3uvMEc/iG/VdWbGPdJMDyOLBvVVJ6stTDR2ffNK5f4mCUzvDW
        +59wkmGq8VzPEn1vz/ZbPpMkMqU3rCioi0jYuyN9e9HGC41TT+iUSPVpz3vCselO/D3jyReX
        McWdmlYjK7rYwkNctbzWL3NR59ry9V9s3qeKuwWm74rzO5Z3k8fk61WDOv0HiSIeDOaL2mrj
        9p1m+t3kOzuda5nIUiWW4oxEQy3mouJEAA6gOnD9AgAA
X-CMS-MailID: 20220922022056epcas1p1c95a2fbb5bd55e254387c2c457732b13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072358epcas1p15d18d4cf27694f894332f975bb971bef
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072358epcas1p15d18d4cf27694f894332f975bb971bef@epcas1p1.samsung.com>
        <20220917072356.2255620-14-jiho.chu@samsung.com>
        <68a87470-2946-cdd0-f1a4-0c0bac906e8c@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 20:42:35 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 17/09/2022 09:23, Jiho Chu wrote:
> > The Trinity Neural Processing Unit (NPU) is a hardware IP for providing
> > hardware acceleration for neural network processing workloads. It has
> > own virtual ISA decoder unit, and controlled by memory mapped control
> > registers. The IP is composed of Common Processor (CP), Digital Signal
> > Processor (DSP) and Deep Learning Accelerator (DLA). ComBox is register
> > set to control IRQ or check overall status of the IP.
> > 
> > Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
> > Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
> > Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > ---
> >  .../bindings/arm/samsung,trinity.yaml         | 115 ++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/samsung,trinity.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/samsung,trinity.yaml b/Documentation/devicetree/bindings/arm/samsung,trinity.yaml
> > new file mode 100644
> > index 000000000000..cd79ec040162
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/samsung,trinity.yaml
> > @@ -0,0 +1,115 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: https://protect2.fireeye.com/v1/url?k=d6ad487f-b7d0a003-d6acc330-74fe485cc33c-c18489118cc5693c&q=1&e=e1fcd741-e7bc-4610-b982-e9d1481f4eb1&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Farm%2Fsamsung%2Ctrinity.yaml%23
> > +$schema: https://protect2.fireeye.com/v1/url?k=eceeef8d-8d9307f1-ecef64c2-74fe485cc33c-c540319d368eacda&q=1&e=e1fcd741-e7bc-4610-b982-e9d1481f4eb1&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> > +
> > +title: Samsung Trinity NPU Family
> > +
> > +maintainers:
> > +  - Jiho Chu <jiho.chu@samsung.com>
> > +
> > +description: |
> > +  The Trinity Neural Processing Unit (NPU) is a hardware IP for providing
> > +  hardware acceleration for neural network processing workloads. It has
> > +  own virtual ISA decoder unit, and controlled by memory mapped control
> > +  registers. The IP is composed of Common Processor (CP), Digital Signal
> > +  Processor (DSP) and Deep Learning Accelerator (DLA). ComBox is register
> > +  set to control IRQ or check overall status of the IP.
> > +
> > +properties:
> > +  compatible:
> > +    const: samsung,trinity
> > +
> > +  samsung,trinity-type:
> > +    description: type of trinity family
> > +    enum: ['triv2']
> 
> No, we have compatible for this.
> 

This property will be removed.

> > +
> > +  samsung,tops:
> > +    description: Performance metric (Tera Operation Per Seconds)
> > +    enum: [2, 8]
> 
> What piece of hardware this describes?
> 

This is related to HW internal structure, but it can be matched from
compotible property. I'll add more value for compitable, and this
will be removed. 


> > +
> > +  samsung,idu_cp:
> 
> No underscores in names.
> 
> Missing ref/type. Missing description. I am not sure that this belongs
> to DT.
> 
> 
> > +    items:
> > +      - description: Address of zero data of CP
> > +      - description: Address of IDU data of CP
> > +      - description: Maximum size of CP's IDU binary
> 
> > +
> > +  samsung,idu_dsp:
> 
> The same.
> 

underscore will be fixed like (samsung,idu,xxxx)

> > +    items:
> > +      - description: Address of zero data of DSP
> > +      - description: Address of IDU data of DSP
> > +      - description: Maximum size of DSP's IDU binary
> > +
> > +  samsung,dspm:
> > +    description: The size of Data Scratch-Pad Memory
> > +
> > +  memory-region:
> > +    description:
> > +      phandle to the reserved memory node to be associated
> > +      with the trinity device. The reserved memory node
> > +      can be a CMA memory node.
> > +      Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> > +
> > +  dma-coherent: true
> > +
> > +  reg:
> > +    items:
> > +      - description: Memory mapped register of CP
> > +      - description: Memory mapped register of DSP
> > +      - description: Memory mapped register of ComBox
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cp-mmreg
> > +      - const: dsp-mmreg
> > +      - const: cbox-mmreg
> 
> Drop "reg" suffixes.
> 

OK.

> > +
> > +  interrupts:
> > +    description: workload complete interrupt
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - samsung,trinity-type
> > +  - samsung,tops
> > +  - samsung,idu_cp
> > +  - samsung,idu_dsp
> > +  - samsung,dspm
> > +  - memory-region
> > +  - dma-coherent
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +
> > +examples:
> > +  - |
> > +    reserved-memory {
> > +        #address-cells = <2>;
> > +        #size-cells = <1>;
> > +        trinity_dram_0: memory@80000000 {
> > +            compatible = "shared-dma-pool";
> > +            no-map;
> > +            reg = <0x0 0x80000000 0x10000000>;
> > +        };
> > +    };
> 
> Drop this part - it is fairly obvious.
> 

OK.

> > +
> > +    triv2@0x30C00000 {
> > +        compatible = "samsung,trinity";
> > +        samsung,trinity-type = "triv2";
> > +        samsung,tops = <8>;
> > +        samsung,idu_cp = /bits/ 64 <0x30400000 0x30400010 0x10000>;
> > +        samsung,idu_dsp = /bits/ 64 <0x30500000 0x30500010 0x10000>;
> > +        samsung,dspm = <0x40000>;
> > +
> > +        memory-region = <&trinity_dram_0>
> > +
> > +        dma-coherent;
> > +
> > +        reg =   <0x0 0x30C10000 0x0 0x10000>, /* CP MMREG base */
> > +                <0x0 0x30D40000 0x0 0x10000>, /* DSP MMREG base */
> > +                <0x0 0x30DF0000 0x0 0x01000>; /* ComBox MMREG base */
> 
> 
> reg and reg-names go after compatible.
> 

OK.

> > +        reg-names = "cp-mmreg", "dsp-mmreg", "cbox-mmreg";
> > +
> > +        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> > +    };
> 
> Best regards,
> Krzysztof
> 
> 

Hi, Krzysztof
Thanks for your review.

Best regards,
Jiho Chu




