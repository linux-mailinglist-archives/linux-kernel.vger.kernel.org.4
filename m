Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885286630A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbjAITnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjAITm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:42:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4503590C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:42:56 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bs20so9336420wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sm+C6Y4VHJEDtGwIvvGgY7BGxijkOAR29lDr/Tbsy3A=;
        b=tDlDq1FkSgoi9HsSAmHq/G1pvTD21qW7XYfQnck5oYb2AhOo9kFjJMrLzYSkivk1T4
         4BPoJn1oyAJsLYH87L+dNhESNeJXB4dkJ5TQ0Gq5UwBIuCdQEfYvPfJmGp6kowUbBj0g
         ZOjVOa+89Z3KIgebtQN+Ug9K2zNt6viJ17kxjohRc91l1gyfcHSBGya+kQEw97VYLr77
         DteJKaG7Pb6gW0/OgmH6lq03RZTQIqOZpYpmB7ZbU9VW1Bnp9mVIofo7kGSSBwBWglSi
         rdV/IAq18wsDLyUVEoVIsE0ga0iIruBN10dy2evrp1LsBCBP8CleQefNS5rvS7xnkUo+
         Ft1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sm+C6Y4VHJEDtGwIvvGgY7BGxijkOAR29lDr/Tbsy3A=;
        b=sv4NE+Nr608Dwwnt1cqdb86h6kdLypHagpMAx8uoXSD0csrl6hAyHwkD8QLUcVqjUd
         GuHzMz8RpsStMI5HaZUxUfGZQJSZAoUS9SCOllCb5vRxq5VQfA8ZBgP+8HalV5gXyVOQ
         nb36AYAZZPc4MFi6tbkGdSC8fwl0K0UKgn+TQ7DuxIBrI9BaMn9SZ3bobdKUSZCGbPbH
         2SUhOOt4STaDFuluFlSC6aIMmd93XzWf4hU0tOpgs8q9CzvsfLeCbLHmxKvomPQlJGUk
         3jVHAyE4J815MTtbR2eIy1D9A+xWXXfwVIkheFasTO1MUli1mcrkSaWttzTVYYK3+o7y
         h0ig==
X-Gm-Message-State: AFqh2kreNKwQo++4p5tU76fjSIvtoE7YqQQWtRYeldwYzkEBhCGfZET+
        VPQcYJmdzgNFd233DrdUSOvhWCYY+5caHTvD7uEHlA==
X-Google-Smtp-Source: AMrXdXvmpe85LGRAEvZEbNLRLiITVTgyGbd3Lmkkw5o1zaaUX68O/76T6yls5toHkzKVDFagcX3kdIZLT8OIDP0ag8Q=
X-Received: by 2002:a05:6000:12cb:b0:28c:459a:d5d with SMTP id
 l11-20020a05600012cb00b0028c459a0d5dmr1401361wrx.654.1673293374842; Mon, 09
 Jan 2023 11:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105030434.255603-1-irogers@google.com> <CAP-5=fXi_9zdhTAoYApiFQoLURAvpEatFzU3uL23o3zs=z25ZQ@mail.gmail.com>
 <CAA6y9eV50Xw6tsq7dDJ61_uNM-yKdN8O+VU=6wcUFr7MGUbOaA@mail.gmail.com>
In-Reply-To: <CAA6y9eV50Xw6tsq7dDJ61_uNM-yKdN8O+VU=6wcUFr7MGUbOaA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 11:42:42 -0800
Message-ID: <CAP-5=fXRr_cTYWhO4=HicrddbwVt=DpmEnvAQMY0sTsgcSx4jQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf script flamegraph: Avoid d3-flame-graph package dependency
To:     Martin Spier <spiermar@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 7:32 AM Martin Spier <spiermar@gmail.com> wrote:
>
> On Thu, Jan 5, 2023 at 1:25 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Jan 4, 2023 at 7:04 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Currently flame graph generation requires a d3-flame-graph template to
> > > be installed. Unfortunately this is hard to come by for things like
> > > Debian [1]. If the template isn't installed warn and download it from
> > > jsdelivr CDN. If downloading fails generate a minimal flame graph
> > > again with the javascript coming from jsdelivr CDN.
> > >
> > > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996839
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/scripts/python/flamegraph.py | 63 ++++++++++++++++++-------
> > >  1 file changed, 45 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
> > > index b6af1dd5f816..808b0e1c9be5 100755
> > > --- a/tools/perf/scripts/python/flamegraph.py
> > > +++ b/tools/perf/scripts/python/flamegraph.py
> > > @@ -25,6 +25,27 @@ import io
> > >  import argparse
> > >  import json
> > >  import subprocess
> > > +import urllib.request
> > > +
> > > +minimal_html = """<head>
> > > +  <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
> >
> > (hopefully fixed Martin Spier's e-mail address)
> >
> > The @4.1.3 comes from the README.md:
> > https://github.com/spiermar/d3-flame-graph/blob/master/README.md
> > Does it make sense just to drop it or use @latest ? It'd be nice not
> > to patch this file for every d3-flame-graph update.
> >
> > Thanks,
> > Ian
>
> Yes, that's the right email.
>
> Using @latest is an option, but it might be better to just use @4 to
> avoid breaking changes. Not expecting any major releases in the near
> future.
>
> Thanks,
> Martin

Thanks Martin! I'll leave it using @4 then. Could I trouble you for an
Acked-by or Reviewed-by for the change? It would be nice to resolve
the Debian bug.

Thanks,
Ian

> >
> > > +</head>
> > > +<body>
> > > +  <div id="chart"></div>
> > > +  <script type="text/javascript" src="https://d3js.org/d3.v7.js"></script>
> > > +  <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.min.js"></script>
> > > +  <script type="text/javascript">
> > > +  const stacks = [/** @flamegraph_json **/];
> > > +  // Note, options is unused.
> > > +  const options = [/** @options_json **/];
> > > +
> > > +  var chart = flamegraph();
> > > +  d3.select("#chart")
> > > +        .datum(stacks[0])
> > > +        .call(chart);
> > > +  </script>
> > > +</body>
> > > +"""
> > >
> > >  # pylint: disable=too-few-public-methods
> > >  class Node:
> > > @@ -50,15 +71,18 @@ class FlameGraphCLI:
> > >          self.args = args
> > >          self.stack = Node("all", "root")
> > >
> > > -        if self.args.format == "html" and \
> > > -                not os.path.isfile(self.args.template):
> > > -            print("Flame Graph template {} does not exist. Please install "
> > > -                  "the js-d3-flame-graph (RPM) or libjs-d3-flame-graph (deb) "
> > > -                  "package, specify an existing flame graph template "
> > > -                  "(--template PATH) or another output format "
> > > -                  "(--format FORMAT).".format(self.args.template),
> > > -                  file=sys.stderr)
> > > -            sys.exit(1)
> > > +        if self.args.format == "html":
> > > +            if os.path.isfile(self.args.template):
> > > +                self.template = f"file://{self.args.template}"
> > > +            else:
> > > +                print(f"""
> > > +Warning: Flame Graph template '{self.args.template}'
> > > +does not exist, a template will be downloaded via http. To avoid this
> > > +please install a package such as the js-d3-flame-graph or
> > > +libjs-d3-flame-graph, specify an existing flame graph template
> > > +(--template PATH) or another output format (--format FORMAT).
> > > +""", file=sys.stderr)
> > > +            self.template = "https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/templates/d3-flamegraph-base.html"
> > >
> > >      @staticmethod
> > >      def get_libtype_from_dso(dso):
> > > @@ -129,15 +153,18 @@ class FlameGraphCLI:
> > >              options_json = json.dumps(options)
> > >
> > >              try:
> > > -                with io.open(self.args.template, encoding="utf-8") as template:
> > > -                    output_str = (
> > > -                        template.read()
> > > -                        .replace("/** @options_json **/", options_json)
> > > -                        .replace("/** @flamegraph_json **/", stacks_json)
> > > -                    )
> > > -            except IOError as err:
> > > -                print("Error reading template file: {}".format(err), file=sys.stderr)
> > > -                sys.exit(1)
> > > +                with urllib.request.urlopen(self.template) as template:
> > > +                    output_str = '\n'.join([
> > > +                        l.decode('utf-8') for l in template.readlines()
> > > +                    ])
> > > +            except Exception as err:
> > > +                print(f"Error reading template {self.template}: {err}\n"
> > > +                      "a minimal flame graph will be generated", file=sys.stderr)
> > > +                output_str = minimal_html
> > > +
> > > +            output_str = output_str.replace("/** @options_json **/", options_json)
> > > +            output_str = output_str.replace("/** @flamegraph_json **/", stacks_json)
> > > +
> > >              output_fn = self.args.output or "flamegraph.html"
> > >          else:
> > >              output_str = stacks_json
> > > --
> > > 2.39.0.314.g84b9a713c41-goog
> > >
