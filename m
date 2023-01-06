Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777F8660354
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbjAFPcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjAFPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:32:16 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7E75D25;
        Fri,  6 Jan 2023 07:31:59 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id o75so2248718yba.2;
        Fri, 06 Jan 2023 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQP/5D3LqTosG+7vRYjRg9axW9DC5iFtmMm9kbIA6S4=;
        b=fpRj6AGHA4XtKSDcDKpCmSdJ7iZtz93UjJW4eyt0E8Y0HA6m2pjJF0Edmb3yyGUSD0
         nmFIP3HAV/4/fEsaHR1WkagVrIyNZVY53D9G8Nv0z12z73PjEF7eqOP2LabG8bdhmvpj
         OFLbQPj/iYb4nZwJFGaL348GJbLCEjRbmnlo1XznWv2oKDpVhP9rAR6LaRR6CQKP3Q2U
         rJGcAU4X/czptrga1MTc8GwkI6t/o1uVK/tEKXWR35Ib66nxWb74wIoi25xS1vr31uPh
         vswd4Uxry24K6QB63vN/xRY27mEV110vK9o3DHQBzwvM0hF72hsGoYyzc92h8HF56j4/
         4zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQP/5D3LqTosG+7vRYjRg9axW9DC5iFtmMm9kbIA6S4=;
        b=CdN4LlxeG+Ip6xSvxrwgND2FnBOKb2GZtqcm2qwokbJUI0zcgkRPO2ak3OT+j6DHc3
         7m372RX3nUSJU6RSdxzLQPJptjObDODvdTiWKtpxam+igEtU9vYCUP02kPaPbpiBpejA
         b+SG8SqelEl5OMOds/zFtV4O1ELkr19ES6RGBqb5XFrwMCuDeuI50QUT1IVn4dcR/B53
         g8XyiyS1WBRrQyb5doJxepZaiEHHbdtl9ZHRZLlLMykjrFDOh3KGaRra8TYBA6v5Qk66
         FMCVdbGpSGa9N7qTl/bHfBWXoQbgQwkiQl97t4qeT5UR3UQg7kdJXA9qQKCrmPuQ3s3R
         tKYw==
X-Gm-Message-State: AFqh2kpjbSnTzbRB2YkaZPfVVaDBOULc9BL4A9/Ap75CrAOHGEPTDYcO
        DvBHc5+b7FiJLK+wE3XmfqUJ8S+R+oU6xiUNL75zbKYm
X-Google-Smtp-Source: AMrXdXt6dpj7QuAOHVjRNg3OwKlcU9IbOAIKq7saQCRvRCp7g7ul5TQRFSj/Dvy9IjJcARHHPJANMQQ2CkX89JxRfgg=
X-Received: by 2002:a25:9bc5:0:b0:706:bb2c:837 with SMTP id
 w5-20020a259bc5000000b00706bb2c0837mr5891970ybo.240.1673019118613; Fri, 06
 Jan 2023 07:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20230105030434.255603-1-irogers@google.com> <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
From:   Martin Spier <spiermar@gmail.com>
Date:   Fri, 6 Jan 2023 07:31:46 -0800
Message-ID: <CAA6y9eV50Xw6tsq7dDJ61_uNM-yKdN8O+VU=6wcUFr7MGUbOaA@mail.gmail.com>
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        996839@bugs.debian.org, Andreas Gerstmayr <agerstmayr@redhat.com>,
        Brendan Gregg <brendan@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 1:25 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Currently flame graph generation requires a d3-flame-graph template to
> > be installed. Unfortunately this is hard to come by for things like
> > Debian [1]. If the template isn't installed warn and download it from
> > jsdelivr CDN. If downloading fails generate a minimal flame graph
> > again with the javascript coming from jsdelivr CDN.
> >
> > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
> >  1 file changed, 45 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> > index b6af1dd5f816..808b0e1c9be5 100755
> > --- a/tools/perf/scripts/python/flamegraph.py
> > +++ b/tools/perf/scripts/python/flamegraph.py
> > @@ -25,6 +25,27 @@ import io
> >  import argparse
> >  import json
> >  import subprocess
> > +import urllib.request
> > +
> > +minimal_html = """<head>
> > +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
>
> (hopefully fixed Martin Spier's e-mail address)
>
> The @4.1.3 comes from the README.md:
> https://github.com/spiermar/d3-flame-graph/blob/master/README.md
> Does it make sense just to drop it or use @latest ? It'd be nice not
> to patch this file for every d3-flame-graph update.
>
> Thanks,
> Ian

Yes, that's the right email.

Using @latest is an option, but it might be better to just use @4 to
avoid breaking changes. Not expecting any major releases in the near
future.

Thanks,
Martin

>
> > +</head>
> > +<body>
> > +  <div id="chart"></div>
> > +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> > +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> > +  <script type="text/javascript">
> > +  const stacks = [/** @flamegraph_json **/];
> > +  // Note, options is unused.
> > +  const options = [/** @options_json **/];
> > +
> > +  var chart = flamegraph();
> > +  d3.select("#chart")
> > +        .datum(stacks[0])
> > +        .call(chart);
> > +  </script>
> > +</body>
> > +"""
> >
> >  # pylint: disable=too-few-public-methods
> >  class Node:
> > @@ -50,15 +71,18 @@ class FlameGraphCLI:
> >          self.args = args
> >          self.stack = Node("all", "root")
> >
> > -        if self.args.format == "html" and \
> > -                not os.path.isfile(self.args.template):
> > -            print("Flame Graph template {} does not exist. Please install "
> > -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> > -                  "package, specify an existing flame graph template "
> > -                  "(--template PATH) or another output format "
> > -                  "(--format FORMAT).".format(self.args.template),
> > -                  file=sys.stderr)
> > -            sys.exit(1)
> > +        if self.args.format == "html":
> > +            if os.path.isfile(self.args.template):
> > +                self.template = f"file://{self.args.template}"
> > +            else:
> > +                print(f"""
> > +Warning: Flame Graph template '{self.args.template}'
> > +does not exist, a template will be downloaded via http. To avoid this
> > +please install a package such as the js-d3-flame-graph or
> > +libjs-d3-flame-graph, specify an existing flame graph template
> > +(--template PATH) or another output format (--format FORMAT).
> > +""", file=sys.stderr)
> > +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> >
> >      @staticmethod
> >      def get_libtype_from_dso(dso):
> > @@ -129,15 +153,18 @@ class FlameGraphCLI:
> >              options_json = json.dumps(options)
> >
> >              try:
> > -                with io.open(self.args.template, encoding="utf-8") as template:
> > -                    output_str = (
> > -                        template.read()
> > -                        .replace("/** @options_json **/", options_json)
> > -                        .replace("/** @flamegraph_json **/", stacks_json)
> > -                    )
> > -            except IOError as err:
> > -                print("Error reading template file: {}".format(err), file=sys.stderr)
> > -                sys.exit(1)
> > +                with urllib.request.urlopen(self.template) as template:
> > +                    output_str = '\n'.join([
> > +                        l.decode('utf-8') for l in template.readlines()
> > +                    ])
> > +            except Exception as err:
> > +                print(f"Error reading template {self.template}: {err}\n"
> > +                      "a minimal flame graph will be generated", file=sys.stderr)
> > +                output_str = minimal_html
> > +
> > +            output_str = output_str.replace("/** @options_json **/", options_json)
> > +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> > +
> >              output_fn = self.args.output or "flamegraph.html"
> >          else:
> >              output_str = stacks_json
> > --
> > 2.39.0.314.g84b9a713c41-goog
> >
