Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF0723C4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbjFFI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjFFIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:55:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45DE8;
        Tue,  6 Jun 2023 01:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686041751; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GW0xPc4Sa1cylTuKVowWNeWjralIkTs84iUHFe2GtdvcgzCiupPhcC/egtmFxpXSbt
    P5jV1VNjr6UeubxRyPHLHhdfCG3Zahig1tM9HYP0bofsUXXilZ/zK9hc7FCFxzFBOC71
    JaKVOCm3rO1PhhwINKTDk2phyqm1bgrNqZ+UAEDnACuBVcPaAenEPByGiUfrxk5uK9cF
    Epv4iCmrDOzAuwyd0r+8DGJeF9O7MKUxGINY9C/m5z18SPVbAtzXi/cTHHUtdRZiZEli
    +yzFNHGDmqu6/x5XewOOHxWJN7cwJ6LAnvPcnwW8MuD4m6IDeKwR5vJQ3KVK1mEKEodf
    Se7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686041751;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BexHV/0Sl/N5FJTkcmkKNLN4abHpu5qYlg15VyapGS8=;
    b=G0qrqe1HfEHmqoN65iw4WwAE9B/CvHenQZVy+6ZIMbvCjIE2EX3TUCBLbJ3l/oVV9m
    OGa8sq5kTKZvvXoWb++xvxLBEObGsHDr8fG+iTVebGKNQZZcrVjxYA2HDg5eC0JVcjLP
    SJyzL9x11PE8dFsAGq0A10IqT8B8EDLf5HhNmNnfJmxlpybuxinGxKj1uVfgrXF0L6p+
    hgy9PJSdHecBuywZB64lghZx+n6oI7arYTiiyoQ0JTrGKGKbOKMUB4Fxx8OoTUaUda7r
    wAXUC+5WsU8cSEOmtySyhc5BztLA8yDxp1keDEpSLrSnrMhFBKFGb/G6mLcfetuGmwp1
    0Yxw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686041751;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BexHV/0Sl/N5FJTkcmkKNLN4abHpu5qYlg15VyapGS8=;
    b=nHm0deeRWOaQfsLdsAlkY4MSx9ONDFylu1nW5rl1bmU+2eJ3iCaKknXIjMVNSInO02
    RoEBCo/iBHriaUT11HeDtzZZfAIvarlMTLRiaH+agt1f8dxGkis++f5OzHJ4TQHIgNpi
    TuliB9fNB3b0oSjyF6Gis95KvViH1L3Yzaxbz1PWMHASdBipL4A1mFnOzhbovdy1rCyD
    /p1vMvl8SCq9H50xS9wY4wLIkx7hjmDR5roK7dbH4DJisfUgSijjBBhLY5HaX7KYn7V9
    Wi10yI5nKziI5FiGOyM8UOr10QhqmyGe859jtTaN0VwFFpeVIlsSZlZeQrrQo0fusEg4
    YEyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686041751;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BexHV/0Sl/N5FJTkcmkKNLN4abHpu5qYlg15VyapGS8=;
    b=zPGX7uvSTet/UZk5nNx+mYgomR+tsZc6ha73lFMFBOxhzYmv1jIyRct9ByK3kutf+R
    xhXOrCdT5EvJn9k6YLBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z568toDD9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 6 Jun 2023 10:55:50 +0200 (CEST)
Date:   Tue, 6 Jun 2023 10:55:44 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 05/14] dt-bindings: remoteproc: Add Qualcomm RPM
 processor/subsystem
Message-ID: <ZH70kG7jZZgd9Esi@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-5-e0a3b6de1f14@gerhold.net>
 <2a479fd0-1d3c-2c28-d2fd-86a8cf610cf9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a479fd0-1d3c-2c28-d2fd-86a8cf610cf9@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<On Tue, Jun 06, 2023 at 08:36:10AM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2023 09:08, Stephan Gerhold wrote:
> > On Qualcomm platforms, most subsystems (e.g. audio/modem DSP) are
> > described as remote processors in the device tree, with a dedicated
> > node where properties and services related to them can be described.
> > 
> > The Resource Power Manager (RPM) is also such a subsystem, with a
> > remote processor that is running a special firmware. Unfortunately,
> > the RPM never got a dedicated node representing it properly in the
> > device tree. Most of the RPM services are described below a top-level
> > /smd or /rpm-glink node.
> 
> Then what is rpm-requests? This is the true RPM. It looks like you now
> duplicate half of it in a node above. Unless you want here to describe
> ways to communicate with the RPM, not the RPM itself.
>

I think you're confusing hardware and firmware here. The rpm-proc node
represents the RPM hardware block (or perhaps the RPM firmware overall),
while rpm-requests is just *one* communication interface provided by the
RPM firmware. Here is a rough picture of the RPM "subsystem" I'm trying
to describe:

                +--------------------------------------------+      
                |       RPM subsystem (qcom,rpm-proc)        |      
                |                                            |      
          reset | +---------------+     +-----+  +-----+     |      
        --------->|               |     | MPM |  | CPR | ... |      
 IPC interrupts | | ARM Cortex-M3 |     +-----+  +-----+     |      
----------------->|               |---     |        |        |      
                | +---------------+  |---------------------- |      
                | +---------------+  |                       |      
                | |   Code RAM    |--|  +------------------+ |      
                | +---------------+  |  |                  | |      
                | +---------------+  |  |   Message RAM    | |      
                | |   Data RAM    |--|--|                  | |      
                | +---------------+  |  +------------------+ |      
                +--------------------|-----------------------+      
                                     v                              
                                    NoC                             

(Somewhat adapted from Figure 8-1 RPM overview in the APQ8016E Technical
 Reference Manual, but I added some extra stuff.)

As you can see neither "SMD" nor "rpm-requests" exist in hardware.
Again, it's just one communication protocol implemented by the RPM
firmware running on the Cortex-M3 processor, much like a webserver
running on a PC.

When the SoC is started only the hardware block exists. Usually a
component in the boot chain loads firmware into the code/data RAM and
then de-asserts the reset line to start the Cortex-M3 processor.

This is not guaranteed to happen. For example, I have a special firmware
version where the firmware is only loaded but not brought out of reset.
In this case Linux is responsible to de-assert the reset line.
In follow-up patches I add that to the outer qcom,rpm-proc node:

	remoteproc {
		compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
		resets = <&gcc GCC_RPM_RESET>;
		iommus = <&apps_smmu 0x0040>;

		smd-edge {
			/* ... */
			rpm-requests {
				qcom,smd-channels = "rpm_requests";
			};
		};
	};

This reset line cannot be described on the rpm-requests node. Until the
firmware is started there is no such thing as "SMD" or "rpm-requests".

When the RPM firmware is started it sets up some data structures in the
message RAM and then begins serving requests, perhaps like this:

               +----------------------------------+                                    
               |          ARM Cortex-M3           |                                    
               | +------------------------------+ |  +--------------------------------+
               | |  RPM Firmware                | |  |          Message RAM           |
 IPC Interrupt | | +----------------------+     | |  | +----------------------------+ |
------------------>| SMD Server           |     | |  | | SMD Data Structures & FIFO | |
               | | | +--------------+     |     | |  | | +--------------+           | |
               | | | | rpm_requests | ... |     | |  | | | rpm_requests |    ...    | |
               | | | +--------------+     | ... | |  | | +--------------+           | |
               | | +----------------------+     | |  | +----------------------------+ |
               | +------------------------------+ |  |                ...             |
               +----------------------------------+  +--------------------------------+

The "smd-edge" node represents the SMD part and "rpm_requests" is one
of the communication channels that can be used to talk to the RPM firmware.

Everything below rpm-requests: clocks, regulators, power domains are
pure firmware constructions. They do not exist in the RPM hardware block,
the firmware just acts as a proxy to collect votes from different
clients and then configures the actual hardware.
 
> 
> > However, SMD/GLINK is just one of the communication channels to the RPM
> > firmware. For example, the MPM interrupt functionality provided by the
> > RPM does not use SMD/GLINK but writes directly to a special memory
> > region allocated by the RPM firmware in combination with a mailbox.
> > Currently there is no good place in the device tree to describe this
> > functionality. It doesn't belong below SMD/GLINK but it's not an
> > independent top-level device either.
> > 
> > Introduce a new "qcom,rpm-proc" compatible that allows describing the
> > RPM as a remote processor/subsystem like all others. The SMD/GLINK node
> > is moved to a "smd-edge"/"glink-edge" subnode consistent with other
> > existing bindings. Additional subnodes (e.g. interrupt-controller for
> > MPM, rpm-master-stats) can be also added there.
> 
> If this was about to stay, you should also update the qcom,smd.yaml, so
> there will be no duplication.
> 

qcom,smd.yaml is deprecated in the next patch (PATCH 07/14).

> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
> > new file mode 100644
> > index 000000000000..c06dd4f66503
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,rpm-proc.yaml
> > @@ -0,0 +1,125 @@
> > [...]
> > +  interrupt-controller:
> > +    type: object
> > +    $ref: /schemas/interrupt-controller/qcom,mpm.yaml#
> > +    description:
> > +      MSM Power Manager (MPM) interrupt controller that monitors interrupts
> > +      when the system is asleep.
> 
> Isn't this a service of RPM?
> 
> > +
> > +  master-stats:
> > +    $ref: /schemas/soc/qcom/qcom,rpm-master-stats.yaml#
> > +    description:
> > +      Subsystem-level low-power mode statistics provided by RPM.
> 
> The same question.
> 

Yes, they are services of the RPM firmware. But they have no relation to
the SMD/GLINK channel.

To clarify this I extend my picture from above with MPM:

                 +----------------------------------+                                    
                 |          ARM Cortex-M3           |                                    
                 | +------------------------------+ |  +--------------------------------+
                 | |  RPM Firmware                | |  |          Message RAM           |
 IPC Interrupt 0 | | +----------------------+     | |  | +----------------------------+ |
 ------------------->| SMD Server           |     | |  | | SMD Data Structures & FIFO | |
                 | | | +--------------+     |     | |  | | +--------------+           | |
                 | | | | rpm_requests | ... |     | |  | | | rpm_requests |    ...    | |
                 | | | +--------------+     | ... | |  | | +--------------+           | |
                 | | +----------------------+     | |  | +----------------------------+ |
 IPC Interrupt 1 | | +----------------------+     | |  | +----------------------------+ |
 ------------------->| MPM virtualization   |<-----------| MPM register copy (vMPM)   | |
                 | | +----------------------+     | |  | +----------------------------+ |
                 | +-----------|------------------+ |  |              ...               |
                 +-------------v--------------------+  +--------------------------------+
                       +--------------+                                                  
                       | MPM Hardware |                                                  
                       +--------------+                                                  

As you can see, SMD and MPM are siblings. The MPM functionality
implemented by the RPM firmware is not a child of the SMD server.

It's a bit like a webserver and emailserver running on the same PC.
Two separate services accessible via different ports and protocols.

Thanks,
Stephan

NOTE: All of this is just my interpretation based on the public hints
that exist. I have no access to internal documentation or source code
that would prove that all of this is correct.
